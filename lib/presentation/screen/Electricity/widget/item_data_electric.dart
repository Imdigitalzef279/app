import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';

class ItemDataElectric extends StatelessWidget {
  const ItemDataElectric({
    super.key,
    required this.path,
    required this.color,
    required this.title,
    required this.content,
    required this.unit,
  });

  final String path;
  final Color color;
  final String title;
  final String content;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        width: (constraints.maxWidth - 12.r) / 2,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: color.withOpacity(0.2)),
              child: SvgPicture.asset(
                path,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              ),
            ),
            Gap(8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: content,
                        style: AppTextStyle.textBase.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary)),
                    TextSpan(
                        text: ' $unit',
                        style: AppTextStyle.textXs.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.grey4D)),
                  ])),
                  Gap(4.h),
                  Text(
                    title,
                    style:
                        AppTextStyle.textXs.copyWith(color: AppColors.grey73),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
