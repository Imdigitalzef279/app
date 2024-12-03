import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/presentation/common_widgets/app_button.dart';
import 'package:solar_energy/presentation/common_widgets/app_lable_text_field.dart';
import 'package:solar_energy/presentation/screen/home_page/widget/fillter_list/widget_filter/item_filter_factory.dart';

class FilterListWidget extends StatefulWidget {
  const FilterListWidget({super.key});

  @override
  State<FilterListWidget> createState() => _FilterListWidgetState();
}

class _FilterListWidgetState extends State<FilterListWidget> {
  late ValueNotifier<String> factorySelect;
  late ValueNotifier<String> totalSelect;
  late ValueNotifier<String> equippedSelect;
  late ValueNotifier<String> timeStart;
  late ValueNotifier<String> timeEnd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    factorySelect = ValueNotifier("Tất cả");
    totalSelect = ValueNotifier("Tất cả");
    equippedSelect = ValueNotifier("Tất cả");
    timeStart = ValueNotifier("Thời gian bắt đầu");
    timeEnd = ValueNotifier("thời gian kết thúc");
  }

  final List<ItemFactoryFilter> factoryFilters = [
    // Loại nhà máy
    ItemFactoryFilter(name: "Tất cả", value: "Tất cả"),
    ItemFactoryFilter(name: "Hộ gia đình", value: "Hộ gia đình"),
    ItemFactoryFilter(name: "C&I", value: "C&I"),
    ItemFactoryFilter(name: "Tiện ích", value: "Tiện ích"),
  ];
  final List<ItemFactoryFilter> totalCapac = [
    // Tổng công suất chuỗi
    ItemFactoryFilter(name: "Tất cả", value: "Tất cả"),
    ItemFactoryFilter(name: "0-10 kWp", value: "0-10 kWp"),
    ItemFactoryFilter(name: "10-50 kWp", value: "10-50 kWp"),
    ItemFactoryFilter(name: "50-100 kWp", value: "50-100 kWp"),
    ItemFactoryFilter(name: "100 kWp-1 MWp", value: "100 kWp-1 MWp"),
    ItemFactoryFilter(name: ">1MWp", value: ">1MWp"),
  ];

  final List<ItemFactoryFilter> factoryEquipped = [
    // Cấu hình nhà máy
    ItemFactoryFilter(name: "Tất cả", value: "Tất cả"),
    ItemFactoryFilter(name: "Pin", value: "Pin"),
    ItemFactoryFilter(name: "Bộ tối ưu", value: "Bộ tối ưu"),
    ItemFactoryFilter(name: "Trạm sạc", value: "Trạm sạc"),
  ];

  final List<ItemFactoryFilter> dayConnect = [
    // Cấu hình nhà máy
    ItemFactoryFilter(name: "Thời gian bắt đầu", value: "Thời gian bắt đầu"),
    ItemFactoryFilter(name: "Thời gian kết thúc", value: "Thời gian kết thúc"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bộ Lọc",
            style: AppTextStyle.textBase.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 12.h,
          ),
          ValueListenableBuilder(
            valueListenable: totalSelect,
            builder: (context, value, child) => ItemFilterFactory(
              listValues: factoryFilters,
              valueSelected: totalSelect.value,
              nameFilter: "Loại nhà máy",
              selectItem: (value) {
                totalSelect.value = value;
              },
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          ValueListenableBuilder(
            valueListenable: equippedSelect,
            builder: (context, value, child) => ItemFilterFactory(
              listValues: totalCapac,
              valueSelected: equippedSelect.value,
              nameFilter: "Tổng công suất chuỗi",
              selectItem: (value) {
                equippedSelect.value = value;
              },
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          ValueListenableBuilder(
            valueListenable: factorySelect,
            builder: (context, value, child) => ItemFilterFactory(
              listValues: factoryEquipped,
              valueSelected: factorySelect.value,
              nameFilter: "Cấu hình nhà máy",
              selectItem: (value) {
                factorySelect.value = value;
              },
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Thời gian kết nối",
                style: AppTextStyle.textSm
                    .copyWith(color: AppColors.textPrimary.withOpacity(0.3)),
              ),
              SizedBox(
                height: 4.h,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(9999),
                          initialDate: DateTime.now());
                      if (pickedDate != null) {
                        timeStart.value =
                            DateFormat('MM/dd/yyyy').format(pickedDate);
                      }
                    },
                    child: ValueListenableBuilder(
                      valueListenable: timeStart,
                      builder: (context, value, child) => Container(
                        width: 1.sw / 2 - 40.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 4.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            color: AppColors.greyFB),
                        child: Text(
                          timeStart.value,
                          style: AppTextStyle.textXs.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary.withOpacity(0.5),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(9999),
                          initialDate: DateTime.now());
                      if (pickedDate != null) {
                        timeEnd.value =
                            DateFormat('MM/dd/yyyy').format(pickedDate);
                      }
                    },
                    child: ValueListenableBuilder(
                      valueListenable: timeEnd,
                      builder: (context, value, child) => Container(
                        width: 1.sw / 2 - 40.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 4.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            color: AppColors.greyFB),
                        child: Text(
                          timeEnd.value,
                          style: AppTextStyle.textXs.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary.withOpacity(0.5),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 12.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Khu Vực",
                style: AppTextStyle.textSm
                    .copyWith(color: AppColors.textPrimary.withOpacity(0.3)),
              ),
              SizedBox(
                height: 4.h,
              ),
              CustomLabelTextField(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                radius: 99.r,
                backgroundColor: AppColors.greyFB,
                hintText: "Nhập tên khu vực.",
                textStyleHint: AppTextStyle.textSm
                    .copyWith(color: AppColors.textPrimary.withOpacity(0.5)),
                textStyleInput:
                    AppTextStyle.textSm.copyWith(color: AppColors.textPrimary),
              )
            ],
          ),
          SizedBox(
            height: 32.h,
          ),
          Row(
            children: [
              AppButton(
                title: "Đặt Lại",
                color: AppColors.white,
                fontSize: 12.sp,
                textColor: AppColors.blueEA,
                width: (1.sw - 40) / 2,
                contentPadding: EdgeInsets.symmetric(vertical: 8.h),
              ),
              AppButton(
                title: "OK",
                color: AppColors.blueEA,
                fontSize: 12.sp,
                textColor: AppColors.white,
                width: (1.sw - 40) / 2,
                contentPadding: EdgeInsets.symmetric(vertical: 8.h),
              )
            ],
          ),
        ],
      ),
    );
  }
}
