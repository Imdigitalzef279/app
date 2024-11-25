import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';

class TabSelectWidget extends StatelessWidget {
  const TabSelectWidget(
      {super.key,
      required this.title,
      this.quantity,
      required this.values,
      required this.selectValues,
      required this.callBack});

  final String title;
  final int? quantity;
  final String values;
  final String selectValues;
  final Function(String) callBack;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(99.r),
      onTap: () {
        callBack.call(values);
        print(values.toString());
      },
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: values == selectValues
              ? AppColors.blueFB.withOpacity(0.3)
              : AppColors.white,
          borderRadius: BorderRadius.circular(99.r),
        ),
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: Row(
          children: [
            Text(
              title,
              style: AppTextStyle.textXs.copyWith(
                  fontWeight: values == selectValues ? FontWeight.w500 : FontWeight.w300, color: AppColors.textPrimary),
            ),
            Text(
              " (${quantity ?? 0})",
              style: AppTextStyle.textXs.copyWith(
                  fontWeight: FontWeight.w300, color: AppColors.grey73),
            )
          ],
        ),
      ),
    );
  }
}
