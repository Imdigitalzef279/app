import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';

class ItemOptionWidget extends StatelessWidget {
  const ItemOptionWidget({super.key, this.icon, this.onTap, this.optionName});
  final String? optionName;
  final Widget? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon ?? const SizedBox(),
        SizedBox(width: 12.w,),
        Text(optionName ?? "--", style: AppTextStyle.textSm.copyWith(fontWeight: FontWeight.w400, color: AppColors.textPrimary),),
      ],
    );
  }
}
