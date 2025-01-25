import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/gen/assets.gen.dart';

class CurrentlyWidget extends StatelessWidget {
  const CurrentlyWidget({
    super.key,
    required this.gridPower,
    required this.loadPower,
    required this.productionPower,
    required this.maxGridPower,
    required this.maxProductionPower,
  });

  final double gridPower;
  final double productionPower;
  final double loadPower;
  final double maxGridPower;
  final double maxProductionPower;


  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.sp),
        margin: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.sp),
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
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                  fontSize: 14.sp),
            ),
            Gap(12.sp),
            Wrap(
                direction: Axis.horizontal,
                runSpacing: 12.sp,
                spacing: 8.sp,
                children: [
                  item(context,
                      path: Assets.icons.square.path,
                      color: AppColors.green50,
                      title: "Tổng sản lượng",
                      value: gridPower + productionPower,
                      unit: "MWH"),
                  item(context,
                      path: Assets.icons.thunderstormSun6854078.path,
                      color: AppColors.blueFF,
                      title: "Cung cấp từ điện điên lưới",
                      value: gridPower,
                      unit: "MWH"),
                  item(context,
                      path: Assets.icons.solarPanelSun.path,
                      color: AppColors.orange43,
                      title: "Cung cấp từ điện mặt trời",
                      value: productionPower,
                      unit: "MWH"),
                  item(context,
                      path: Assets.icons.thunderstormSun6854078.path,
                      color: AppColors.grey,
                      title: "Công suất điện lưới tối đa",
                      value: maxGridPower,
                      unit: "KW"),
                  item(context,
                      path: Assets.icons.thunderstormSun6854078.path,
                      color: AppColors.grey,
                      title: "Công suất điện măt trời tối đa",
                      value: maxProductionPower,
                      unit: "KW"),
                  // item(context,
                  //     path: Assets.icons.revenue.path,
                  //     color: AppColors.orange43,
                  //     title: "Doanh thu hôm nay",
                  //     content: "12,43",
                  //     unit: "CNV"),
                ])
          ],
        ));
  }

  Widget item(BuildContext context,
      {required String path,
      required Color color,
      required String title,
      required double value,
      required String unit}) {
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        width: (constraints.maxWidth - 12.sp) / 2,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.sp),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.sp),
                  color: color.withOpacity(0.2)),
              child: SvgPicture.asset(
                path,
                width: 20.sp,
                height: 20.sp,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              ),
            ),
            Gap(8.sp),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: value.toStringAsFixed(1),
                        style: AppTextStyle.textSm.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary)),
                    TextSpan(
                        text: ' $unit',
                        style: AppTextStyle.textXs.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: AppColors.grey4D)),
                  ])),
                  Gap(4.sp),
                  Text(
                    title,
                    style: AppTextStyle.textXs
                        .copyWith(color: AppColors.grey73, fontSize: 12.sp),
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
