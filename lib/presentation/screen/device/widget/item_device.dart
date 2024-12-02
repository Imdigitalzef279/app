import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      borderRadius: BorderRadius.circular(16.r),
      child: Ink(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: AppColors.white,
        ),
        child: Column(
          children: [
            // title
            Row(
              children: [
                Text("100KTL-M2(COM1-12)", style: AppTextStyle.textBase.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600),),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: const Color(0xFFff9f43).withOpacity(0.1),
                  ),
                  child: Text("Dừng", style: AppTextStyle.textXs.copyWith(color: const Color(0xFFff9f43)),),
                )
              ],
            ),

            SizedBox(height: 12.h,),

            // body
            rowItem(name: "Số sê-ri", content: "BN2461058455"),
            const Divider(color: AppColors.greyFB,),
            rowItem(name: "Loại thiết bị", content: "Bộ biến tần"),
            const Divider(color: AppColors.greyFB,),
            rowItem(name: "Trạng thái bộ biến tần", content: "Dừng"),
            const Divider(color: AppColors.greyFB,),
            rowItem(name: "Công suất thuần", content: "0,000 kW"),
            const Divider(color: AppColors.greyFB,),
            rowItem(name: "Sản lượng hôm nay", content: "203,05 kWh"),
            const Divider(color: AppColors.greyFB,),
            rowItem(name: "Ngày hết hạn bảo hành", content: "2029/09/23"),
          ],
        ),
      ),
    );
  }

  Widget rowItem({required String name, required String content}){
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(name,style: AppTextStyle.textSm.copyWith(color: AppColors.textPrimary.withOpacity(0.5)),),
        ),
        SizedBox(width: 16.h,),
        Expanded(
          flex: 3,
          child: Text(content,style: AppTextStyle.textSm.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w400),),
        )
      ],
    );
  }
}
