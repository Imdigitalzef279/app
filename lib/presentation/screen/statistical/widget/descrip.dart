import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget(
      {super.key,
      required this.color,
      required this.name,
      required this.selection,
      required this.callback});

  final Color color;
  final String name;
  final bool selection;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        callback.call();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: selection ? AppColors.greyEF : const Color(0xFFFFFFFF)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8.sp,
              height: 8.sp,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99), color: color),
            ),
            Gap(8.sp),
            Text(
              name,
              style: AppTextStyle.textXs
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 12.sp),
            )
          ],
        ),
      ),
    );
  }
}
