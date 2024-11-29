import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';

class BenefitsWidget extends StatelessWidget {
  const BenefitsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.r),
        margin: EdgeInsets.all(12.r),
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
              'Lợi ích môi trường',
              style: AppTextStyle.textSm.copyWith(
                  fontWeight: FontWeight.w600, color: AppColors.textPrimary),
            ),
            Gap(12.h),
            SizedBox(
              height: 130.h,
              child: Row(
                children: [
                  item(
                      title: "Mức than tiêu chuẩn tiết kiệm được",
                      value: "2,32",
                      color: AppColors.blue),
                  Gap(12.w),
                  item(
                      title: "Khí thải đã giảm được",
                      value: "2,74",
                      color: AppColors.orange),
                  Gap(12.w),
                  item(
                      title: "Số lượng cây tương đương đã trồng",
                      value: "6",
                      color: AppColors.green50),
                ],
              ),
            )
          ],
        ));
  }

  Widget item(
      {required String title, required String value, required Color color}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color.withOpacity(0.2), AppColors.white])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: AppTextStyle.textSm.copyWith(
                  fontWeight: FontWeight.w600, color: AppColors.textPrimary),
            ),
            Text(
              title,
              style: AppTextStyle.textXs.copyWith(color: AppColors.grey4D),
            )
          ],
        ),
      ),
    );
  }
}
