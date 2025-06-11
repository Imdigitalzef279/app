import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';

class ItemErrorWidget extends StatelessWidget {
  const ItemErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
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
                "Lỗi chức nng tự kiểm tra AFCI Lỗi chức nng tự kiểm tra AFCI",
                style: AppTextStyle.textSm.copyWith(
                    color: AppColors.textPrimary, fontWeight: FontWeight.w600),
              )),
            ],
          ),
          SizedBox(
            height: 12.w,
          ),
          rowItem(title: "Trạng thái quy trình loại bỏ lỗi", content: "--"),
          const Divider(),
          rowItem(title: "Tên thiết bị", content: "100KTL-M2(COM1-13)"),
          const Divider(),
          rowItem(title: "Tên nhà máy", content: "thien son"),
          const Divider(),
          rowItem(title: "Thời gian xảy ra", content: "22/11/2024 - 05:54:50"),
        ],
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
                  .copyWith(color: AppColors.textPrimary.withOpacity(0.5)),
              textAlign: TextAlign.left,
            )),
        SizedBox(
          width: 8.w,
        ),
        Expanded(
            flex: 3,
            child: Text(
              content,
              style: AppTextStyle.textXs.copyWith(color: AppColors.textPrimary),
              textAlign: TextAlign.left,
            )),
      ],
    );
  }
}
