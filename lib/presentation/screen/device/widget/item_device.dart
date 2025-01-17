import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/presentation/routes/route_name.dart';

class ItemDevice extends StatelessWidget {
  const ItemDevice({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteName.detailDevice);
      },
      borderRadius: BorderRadius.circular(12.sp),
      child: Ink(
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.sp),
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
          children: [
            // title
            Row(
              children: [
                Text(
                  "100KTL-M2(COM1-12)",
                  style: AppTextStyle.textSm.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 4.sp, vertical: 2.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.sp),
                    color: const Color(0xFFff9f43).withOpacity(0.1),
                  ),
                  child: Text(
                    "Dừng",
                    style: AppTextStyle.textXs.copyWith(
                        color: const Color(0xFFff9f43), fontSize: 12.sp),
                  ),
                )
              ],
            ),
            Gap(8.sp),
            // body
            rowItem(name: "Số sê-ri", content: "BN2461058455"),
            const Divider(
              color: AppColors.greyFB,
            ),
            rowItem(name: "Loại thiết bị", content: "Bộ biến tần"),
            const Divider(
              color: AppColors.greyFB,
            ),
            rowItem(name: "Trạng thái bộ biến tần", content: "Dừng"),
            const Divider(
              color: AppColors.greyFB,
            ),
            rowItem(name: "Công suất thuần", content: "0,000 kW"),
            const Divider(
              color: AppColors.greyFB,
            ),
            rowItem(name: "Sản lượng hôm nay", content: "203,05 kWh"),
            const Divider(
              color: AppColors.greyFB,
            ),
            rowItem(name: "Ngày hết hạn bảo hành", content: "2029/09/23"),
          ],
        ),
      ),
    );
  }

  Widget rowItem({required String name, required String content}) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            name,
            style: AppTextStyle.textXs.copyWith(
                color: AppColors.textPrimary.withOpacity(0.5), fontSize: 12.sp),
          ),
        ),
        Gap(12.sp),
        Expanded(
          flex: 3,
          child: Text(
            content,
            style: AppTextStyle.textXs.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w400,
                fontSize: 12.sp),
          ),
        )
      ],
    );
  }
}
