import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/application/cubit/app_cubit.dart';
import 'package:solar_energy/gen/assets.gen.dart';
import 'package:solar_energy/presentation/common_widgets/app_load_more.dart';
import 'package:solar_energy/presentation/common_widgets/app_toast.dart';
import 'package:solar_energy/presentation/screen/home_page/bloc/home_page_cubit.dart';
import 'package:solar_energy/presentation/screen/home_page/widget/item_factory_hoz.dart';
import 'package:solar_energy/presentation/screen/home_page/widget/tab_widget.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late ValueNotifier<String> selectTab;
  late final HomePageCubit _cubit;
  bool _isInit = false; // red flag

  @override
  void initState() {
    super.initState();
    selectTab = ValueNotifier("Tất cả");
  }



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      _cubit = BlocProvider.of<HomePageCubit>(context);
      _cubit.getProjects();
      _isInit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.white,
        title: Text(
          LocalizationsUtils.localizations.factory,
          style: AppTextStyle.textBase.copyWith(fontWeight: FontWeight.w600),
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () =>
        //           _showCreateStationDialog(context, _cubit.state.projectID),
        //       icon: const Icon(
        //         Icons.add,
        //         size: 22,
        //       ))
        // ],
      ),
      backgroundColor: AppColors.greyFB,
      body: SafeArea(
          child: Column(
        children: [
          // tabview and search
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(16.r),
                    bottomLeft: Radius.circular(16.r))),
            child: BlocBuilder<HomePageCubit, HomePageState>(
              builder: (context, state) => Column(
                children: [
                  ValueListenableBuilder(
                    valueListenable: selectTab,
                    builder: (context, value, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TabSelectWidget(
                          title: "Tất cả",
                          quantity: _cubit.state.allStation,
                          values: "Tất cả",
                          selectValues: selectTab.value,
                          callBack: (value) {
                            selectTab.value = value;
                          },
                          iconTab: Assets.icons.allIconLine.svg(
                              width: 16,
                              colorFilter: ColorFilter.mode(
                                  AppColors.greyAE.withOpacity(0.7),
                                  BlendMode.srcIn)),
                          iconSelectTab: Assets.icons.allIconBold.svg(
                              width: 16,
                              colorFilter: ColorFilter.mode(
                                  AppColors.greyAE.withOpacity(0.7),
                                  BlendMode.srcIn)),
                        ),
                        const VerticalDivider(
                          width: 1,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        TabSelectWidget(
                          title: "Bình thường",
                          quantity: _cubit.state.active,
                          values: "Bình thường",
                          selectValues: selectTab.value,
                          callBack: (value) {
                            selectTab.value = value;
                          },
                          iconTab: Assets.icons.checkCircleLine.svg(
                              width: 16,
                              colorFilter: ColorFilter.mode(
                                  AppColors.green50.withOpacity(0.3),
                                  BlendMode.srcIn)),
                          iconSelectTab: Assets.icons.checkCircleBold.svg(
                              width: 16,
                              colorFilter: ColorFilter.mode(
                                  AppColors.green50.withOpacity(0.3),
                                  BlendMode.srcIn)),
                        ),
                        const VerticalDivider(
                            width: 1, thickness: 1, color: Colors.grey),
                        TabSelectWidget(
                          title: "Bị lỗi",
                          quantity: _cubit.state.warning,
                          values: "Bị lỗi",
                          selectValues: selectTab.value,
                          callBack: (value) {
                            selectTab.value = value;
                          },
                          iconTab: Assets.icons.exclamationLine.svg(
                              width: 16,
                              colorFilter: ColorFilter.mode(
                                  AppColors.red14.withOpacity(0.7),
                                  BlendMode.srcIn)),
                          iconSelectTab: Assets.icons.exclamationBold.svg(
                              width: 16,
                              colorFilter: ColorFilter.mode(
                                  AppColors.red14.withOpacity(0.7),
                                  BlendMode.srcIn)),
                        ),
                        const VerticalDivider(
                            width: 1, thickness: 1, color: Colors.grey),
                        TabSelectWidget(
                          title: "Ngoại tuyến",
                          quantity: _cubit.state.loss,
                          values: "Ngoại tuyến",
                          selectValues: selectTab.value,
                          callBack: (value) {
                            selectTab.value = value;
                          },
                          iconSelectTab: Assets.icons.wifiXmark.svg(
                              width: 16,
                              colorFilter: ColorFilter.mode(
                                  AppColors.yellow57.withOpacity(0.7),
                                  BlendMode.srcIn)),
                          iconTab: Assets.icons.wifiXmark.svg(
                              width: 16,
                              colorFilter: ColorFilter.mode(
                                  AppColors.yellow57.withOpacity(0.7),
                                  BlendMode.srcIn)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          12.verticalSpace,
          // body include content
          Expanded(
            child: AppLoadMore(
              onRefresh: () {
                _cubit.getProjects();
              },
              onLoadMore: () {
                //_cubit.getProjectsMore();
              },
              child: BlocConsumer<HomePageCubit, HomePageState>(
                listener: (context, state) {
                  state.resultProjects.when(
                      loading: () =>
                          BlocProvider.of<AppCubit>(context).showLoading(),
                      success: (data) =>
                          BlocProvider.of<AppCubit>(context).hideShowLoading(),
                      error: (error) {
                        BlocProvider.of<AppCubit>(context).hideShowLoading();
                        AppToast.showToastError(title: error);
                      });
                },
                builder: (BuildContext context, HomePageState state) {
                  final items = state.resultProjects.data ?? [];

                  return Column(
                    children: [
                      for (int i = 0; i < items.length; i++) ...[
                        ItemFactoryHoz(project: items[i]),
                        if (i < items.length - 1) 8.verticalSpace,
                      ]
                    ],
                  );
                },
              ),
            ),
          )
        ],
      )),
    );
  }

  // new station //
  // void _showCreateStationDialog(BuildContext context, int projectId) {
  //   final _formKey = GlobalKey<FormState>();
  //   final nameController = TextEditingController();
  //   final descriptionController = TextEditingController();
  //
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text("Tạo Trạm Mới"),
  //         content: Form(
  //           key: _formKey,
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               // Hiển thị projectId, không cho sửa
  //               Align(
  //                 alignment: Alignment.centerLeft,
  //                 child: Text(
  //                   "Project ID: $projectId",
  //                   style: const TextStyle(fontWeight: FontWeight.w600),
  //                 ),
  //               ),
  //               const SizedBox(height: 16),
  //               // Nhập tên trạm
  //               TextFormField(
  //                 controller: nameController,
  //                 decoration: const InputDecoration(
  //                   labelText: "Tên trạm",
  //                   border: OutlineInputBorder(),
  //                 ),
  //                 validator: (value) => value == null || value.isEmpty
  //                     ? "Vui lòng nhập tên trạm"
  //                     : null,
  //               ),
  //               const SizedBox(height: 12),
  //               // Nhập mô tả
  //               TextFormField(
  //                 controller: descriptionController,
  //                 decoration: const InputDecoration(
  //                   labelText: "Mô tả",
  //                   border: OutlineInputBorder(),
  //                 ),
  //                 validator: (value) => value == null || value.isEmpty
  //                     ? "Vui lòng nhập mô tả"
  //                     : null,
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () => backWidget(),
  //             child: const Text("Huỷ"),
  //           ),
  //           ElevatedButton(
  //             onPressed: () async {
  //               if (_formKey.currentState?.validate() ?? false) {
  //                 final requestBody = PowerStationRequest(
  //                   projectId: projectId,
  //                   name: nameController.text,
  //                   code: "",
  //                   description: descriptionController.text,
  //                   latitude: "",
  //                   longitude: "",
  //                   planViewPath: "",
  //                 );
  //
  //                 final check = await _cubit.createPowerStation(requestBody);
  //                 backWidget();
  //                 if (check) {
  //                   _cubit.getProjects();
  //                 }
  //               }
  //             },
  //             child: const Text("Tạo"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void backWidget() {
    Navigator.pop(context);
  }
}
