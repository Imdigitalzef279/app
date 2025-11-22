import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/presentation/common_widgets/app_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../application/constants/app_color.dart';

class BottomContactInfo extends StatelessWidget {
  const BottomContactInfo({super.key});

  final String tel = "0985629282";
  final String mail = "info@krapower.com";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      width: 1.sw,
      child: Column(
        children: [
          Text(
            LocalizationsUtils.localizations.contact_information,
            style: AppTextStyle.textSm.copyWith(
                color: AppColors.textPrimary, fontWeight: FontWeight.w600),
          ),
          Gap(12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 8.h,
                  ),
                  title: tel,
                  color: AppColors.blueF8,
                  fontSize: 12,
                  textColor: AppColors.white,
                  width: (1.sw - 32.w) / 2,
                  onPressed: () {
                    launchUrlString('tel:${tel.toString()}');
                  },
                ),
                AppButton(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 8.h,
                  ),
                  title: mail,
                  color: AppColors.blueF8,
                  fontSize: 12,
                  textColor: AppColors.white,
                  width: (1.sw - 32.w) / 2,
                  onPressed: () {
                    launchUrlString('mailto:+${mail.toString()}');
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
