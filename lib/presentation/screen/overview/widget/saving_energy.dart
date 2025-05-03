import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/gen/assets.gen.dart';

class SavingEnergy extends StatelessWidget {
  const SavingEnergy({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.greyDF.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 2),
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dữ liệu hiện tại',
              style: AppTextStyle.textSm.copyWith(
                  fontWeight: FontWeight.w600, color: AppColors.textPrimary),
            ),
            Gap(12.h),
            Wrap(
                direction: Axis.horizontal,
                runSpacing: 16.r,
                spacing: 12.r,
                children: [
                  item(context,
                      path: Assets.icons.thunderstormSun6854078.path,
                      color: AppColors.blueFF,
                      title: "Sản lượng cao điểm",
                      content: "2,37",
                      unit: "Kw"),
                  item(context,
                      path: Assets.icons.revenue.path,
                      color: AppColors.orange43,
                      title: "Sản lượng thấp điểm",
                      content: "12,43",
                      unit: "Kw"),
                  item(context,
                      path: Assets.icons.square.path,
                      color: AppColors.green50,
                      title: "Sản lượng thường điểm",
                      content: "5,77",
                      unit: "Kw"),
                  item(context,
                      path: Assets.icons.thunderstormSun6854078.path,
                      color: AppColors.grey,
                      title: "Tổng tiền",
                      content: "100,372",
                      unit: "Dong"),
                ])
          ],
        ));
  }

  Widget item(BuildContext context,
      {required String path,
        required Color color,
        required String title,
        required String content,
        required String unit}) {
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
                width: 20.r,
                height: 20.r,
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
                                fontSize: 10.sp,
                                color: AppColors.grey4D)),
                      ])),
                  Gap(4.h),
                  Text(
                    title,
                    style: AppTextStyle.textXs
                        .copyWith(color: AppColors.grey73, fontSize: 10.sp),
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
