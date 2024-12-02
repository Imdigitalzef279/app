import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/presentation/common_widgets/app_network_image.dart';

class BasicAccountWidget extends StatelessWidget {
  const BasicAccountWidget(
      {super.key, this.email, this.imageLink, this.userName});

  final String? userName;
  final String? email;
  final String? imageLink;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r), color: AppColors.white),
      child: Column(
        children: [
          AppNetworkImage(
            imageLink ??
                "https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png",
            width: 1.sw / 3,
            height: 1.sw / 3,
            radius: 99.r,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 24.w,),
          Text(userName ?? "--", style: AppTextStyle.textBase.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w500),),
          SizedBox(height: 12.h,),
          Text(email ?? "--", style: AppTextStyle.textXs.copyWith(color: AppColors.textPrimary.withOpacity(0.5), fontWeight: FontWeight.w400),)
        ],
      ),
    );
  }
}
