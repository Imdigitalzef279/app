import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';

class ItemAlarm extends StatelessWidget {
  const ItemAlarm({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Ink(
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.error_rounded,
                  size: 22.w,
                  color: const Color(0xFFee5253),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                    child: Text(
                      "Bảo vệ khi có lỗi giao tiếp",
                      style: AppTextStyle.textSm.copyWith(
                          color: AppColors.textPrimary, fontWeight: FontWeight.w600),
                    )),
              ],
            ),
            SizedBox(
              height: 12.w,
            ),
            rowItem(title: "Thời gian xảy ra", content: "08/11/2024 - 06:55:07"),
            const Divider(),
            rowItem(title: "Thời gian xóa", content: "08/11/2024 - 06:55:07"),
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
              style: AppTextStyle.textXs
                  .copyWith(color: AppColors.textPrimary.withOpacity(0.5), fontWeight: FontWeight.w500),
              textAlign: TextAlign.left,
            )),
        SizedBox(
          width: 8.w,
        ),
        Expanded(
            flex: 3,
            child: Text(
              content,
              style: AppTextStyle.textXs.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w500),
              textAlign: TextAlign.left,
            )),
      ],
    );
  }
}
