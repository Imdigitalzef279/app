import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';

class ItemAlarmWater extends StatelessWidget {
  const ItemAlarmWater({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12.sp),
      child: Ink(
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(12.sp)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_rounded,
                  size: 20.sp,
                  color: const Color(0xFFee5253),
                ),
                Gap(8.sp),
                Expanded(
                    child: Text(
                  "Cảnh báo rò rỉ nước",
                  style: AppTextStyle.textSm.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600),
                )),
              ],
            ),
            Gap(4.sp),
            rowItem(
                title: "Thời gian xảy ra", content: "08/11/2024 - 06:55:07"),
          ],
        ),
      ),
    );
  }

  Widget rowItem({required String title, required String content}) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Text(
              title,
              style: AppTextStyle.textXs.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.textPrimary.withOpacity(0.5),
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.left,
            )),
        Gap(8.sp),
        Expanded(
            flex: 3,
            child: Text(
              content,
              style: AppTextStyle.textXs.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.left,
            )),
      ],
    );
  }
}
