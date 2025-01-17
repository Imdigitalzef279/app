import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/gen/assets.gen.dart';

class TabSelectWidget extends StatelessWidget {
  const TabSelectWidget({super.key,
    required this.title,
    this.quantity,
    required this.values,
    required this.selectValues,
    required this.callBack,
    required this.iconTab,
    required this.iconSelectTab
  });

  final String title;
  final int? quantity;
  final String values;
  final String selectValues;
  final Function(String) callBack;
  final Widget iconTab;
  final Widget iconSelectTab;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(99.r),
      onTap: () {
        callBack.call(values);
      },
      child: AnimatedContainer(
        width: (1.sw - 76.w) / 4,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        decoration: BoxDecoration(
            color: values == selectValues
                ? AppColors.blueFB.withOpacity(0.3)
                : AppColors.greyFB,
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(
                color: values == selectValues
                    ? Colors.blueAccent
                    : AppColors.greyFB)),
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        // child: Column(
        //   children: [
        //     Text(
        //       title,
        //       style: AppTextStyle.textXs.copyWith(
        //           fontWeight: values == selectValues
        //               ? FontWeight.w500
        //               : FontWeight.w300,
        //           color: AppColors.textPrimary,
        //           fontSize: 10.sp),
        //     ),
        //     Text(
        //       " ${quantity ?? 0}",
        //       style: AppTextStyle.textXs.copyWith(
        //           fontWeight: values == selectValues
        //               ? FontWeight.w500
        //               : FontWeight.w300, color: AppColors.grey73),
        //     )
        //   ],
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            values != selectValues ? iconTab : iconSelectTab,
            4.horizontalSpace,
            Text(
              " ${quantity ?? 0}",
              style: AppTextStyle.textXs.copyWith(
                  fontWeight: values == selectValues
                      ? FontWeight.w500
                      : FontWeight.w300,
                  color: AppColors.grey73),
            )
          ],
        ),
      ),
    );
  }
}
