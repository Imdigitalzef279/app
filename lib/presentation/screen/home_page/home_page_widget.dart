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
import 'package:solar_energy/presentation/screen/home_page/widget/item_factory_hoz.dart';
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
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.white,
        title: Text(
          LocalizationsUtils.localizations.factory,
          style: AppTextStyle.textBase.copyWith(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {
              AppBottomSheet.showBottomSheet(context,
                  child: const FilterListWidget());
            },
            icon: Icon(
              Icons.filter_list_outlined,
              size: 16.w,
            ),
          )
        ],
      ),
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
            child: Column(
              children: [
                ValueListenableBuilder(
                  valueListenable: selectTab,
                  builder: (context, value, child) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TabSelectWidget(
                        title: "Tất cả",
                        quantity: 3,
                        values: "Tất cả",
                        selectValues: selectTab.value,
                        callBack: (value) {
                          selectTab.value = value;
                        },
                        iconTab: Assets.icons.allIconLine.svg(
                          width: 16,
                            colorFilter: ColorFilter.mode(AppColors.greyAE.withOpacity(0.7),BlendMode.srcIn)

                        ),
                        iconSelectTab: Assets.icons.allIconBold.svg(
                          width: 16,
                            colorFilter: ColorFilter.mode(AppColors.greyAE.withOpacity(0.7),BlendMode.srcIn)

                        ),
                      ),
                      const VerticalDivider(
                        width: 1,
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      TabSelectWidget(
                        title: "Bình thường",
                        quantity: 3,
                        values: "Bình thường",
                        selectValues: selectTab.value,
                        callBack: (value) {
                          selectTab.value = value;
                        },
                        iconTab: Assets.icons.checkCircleLine.svg(
                          width: 16,
                          colorFilter: ColorFilter.mode(AppColors.green50.withOpacity(0.3),BlendMode.srcIn)
                        ),
                        iconSelectTab: Assets.icons.checkCircleBold.svg(
                          width: 16,
                            colorFilter: ColorFilter.mode(AppColors.green50.withOpacity(0.3),BlendMode.srcIn)
                        ),
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
                        iconTab: Assets.icons.exclamationLine.svg(
                          width: 16,
                            colorFilter: ColorFilter.mode(AppColors.red14.withOpacity(0.7),BlendMode.srcIn)

                        ),
                        iconSelectTab: Assets.icons.exclamationBold.svg(
                          width: 16,
                            colorFilter: ColorFilter.mode(AppColors.red14.withOpacity(0.7),BlendMode.srcIn)
                        ),
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
                        iconSelectTab: Assets.icons.wifiXmark.svg(
                          width: 16,
                            colorFilter: ColorFilter.mode(AppColors.yellow57.withOpacity(0.7),BlendMode.srcIn)
                        ),
                        iconTab: Assets.icons.wifiXmark.svg(
                          width: 16,
                            colorFilter: ColorFilter.mode(AppColors.yellow57.withOpacity(0.7),BlendMode.srcIn)

                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          12.verticalSpace,
          // body include content
          Expanded(
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => const ItemFactoryHoz(),
                separatorBuilder: (context, index) => 8.verticalSpace,
                itemCount: 10),
          )
        ],
      )),
    );
  }
}
