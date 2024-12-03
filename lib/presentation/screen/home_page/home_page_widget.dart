import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/gen/assets.gen.dart';
import 'package:solar_energy/presentation/common_widgets/app_bottom_sheet.dart';
import 'package:solar_energy/presentation/common_widgets/app_lable_text_field.dart';
import 'package:solar_energy/presentation/screen/home_page/widget/fillter_list/fillter_list.dart';
import 'package:solar_energy/presentation/screen/home_page/widget/item_factory.dart';
import 'package:solar_energy/presentation/screen/home_page/widget/tab_widget.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late ValueNotifier<String> selectTab;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectTab = ValueNotifier("Tất cả");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          LocalizationsUtils.localizations.factory,
          style: AppTextStyle.textBase.copyWith(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          children: [
            // tabview and search
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.r)),
              child: Column(
                children: [
                  ValueListenableBuilder(
                    valueListenable: selectTab,
                    builder: (context, value, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TabSelectWidget(
                          title: "Tất cả",
                          quantity: 1,
                          values: "Tất cả",
                          selectValues: selectTab.value,
                          callBack: (value) {
                            selectTab.value = value;
                          },
                        ),
                        const VerticalDivider(
                          width: 1,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        TabSelectWidget(
                          title: "Bình thường",
                          quantity: 1,
                          values: "Bình thường",
                          selectValues: selectTab.value,
                          callBack: (value) {
                            selectTab.value = value;
                          },
                        ),
                        const VerticalDivider(
                            width: 1, thickness: 1, color: Colors.grey),
                        TabSelectWidget(
                          title: "Bị lỗi",
                          quantity: 0,
                          values: "Bị lỗi",
                          selectValues: selectTab.value,
                          callBack: (value) {
                            selectTab.value = value;
                          },
                        ),
                        const VerticalDivider(
                            width: 1, thickness: 1, color: Colors.grey),
                        TabSelectWidget(
                          title: "Ngoại tuyến",
                          quantity: 0,
                          values: "Ngoại tuyến",
                          selectValues: selectTab.value,
                          callBack: (value) {
                            selectTab.value = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 8,
                          child: CustomLabelTextField(
                            backgroundColor: AppColors.greyFB,
                            hintText: LocalizationsUtils
                                .localizations.input_factory_name,
                            textStyleHint: AppTextStyle.textXs
                                .copyWith(color: AppColors.grey73),
                            contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                            radius: 99.r,
                            prefixIcon: Assets.icons.search.svg(
                                width: 16.w,
                                height: 16.w,
                                color: AppColors.textPrimary.withOpacity(0.7)),
                          )),
                      Expanded(
                          flex: 1,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(99.r),
                            onTap: () {
                              AppBottomSheet.showBottomSheet(context, child: const FilterListWidget());
                            },
                            child: Icon(
                              Icons.filter_list_outlined,
                              size: 20.r,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),

            // body include content
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                  itemBuilder: (context, index) => const ItemFactory(),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 8.h,
                      ),
                  itemCount: 4),
            )
          ],
        ),
      )),
    );
  }
}
