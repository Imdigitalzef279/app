import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/gen/assets.gen.dart';
import 'package:solar_energy/presentation/common_widgets/app_bottom_sheet.dart';
import 'package:solar_energy/presentation/common_widgets/app_lable_text_field.dart';
import 'package:solar_energy/presentation/screen/alarm_infor/alarm_infor_screen.dart';
import 'package:solar_energy/presentation/screen/alarm_infor/widget/item_alarm.dart';

class HistoryAlarm extends StatelessWidget {
  const HistoryAlarm({super.key, required this.listCurrent});

  final List<ErrorDevice> listCurrent;

  @override
  Widget build(BuildContext context) {
    return listCurrent.isEmpty == false
        ? Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.images.exclamationMark
              .image(width: 1.sw / 3, height: 1.sw / 3, fit: BoxFit.fill),
          Gap(12.h),
          Text(
            "Không có dữ liệu",
            style: AppTextStyle.textSm.copyWith(
                color: AppColors.textPrimary.withOpacity(0.5),
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    )
        : Column(children: [
      Container(
        padding: EdgeInsets.only(bottom: 8.h, left: 16.w, right: 16.w),
        color: AppColors.white,
        child: Row(
          children: [
            Expanded(
                flex: 8,
                child: CustomLabelTextField(
                  backgroundColor: AppColors.white,
                  hintText: "Nhập tên báo động.",
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
                  },
                  child: Icon(
                    Icons.filter_list_outlined,
                    size: 20.r,
                  ),
                )),
          ],
        ),
      ),
      Gap(5.h),
      Expanded(
        child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            itemBuilder: (context, index) => const ItemAlarm(),
            separatorBuilder: (context, index) => Gap(12.h),
            itemCount: 10),
      ),
    ]);
  }
}
