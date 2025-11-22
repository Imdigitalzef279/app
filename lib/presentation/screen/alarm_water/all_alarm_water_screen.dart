import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/presentation/screen/alarm_water/widget/item_alarm_water.dart';

class AllAlarmWaterScreen extends StatefulWidget {
  const AllAlarmWaterScreen({super.key});

  @override
  State<AllAlarmWaterScreen> createState() => _AllAlarmWaterScreenState();
}

class _AllAlarmWaterScreenState extends State<AllAlarmWaterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyFB,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        title: Text(
          LocalizationsUtils.localizations.allWarnings,
          style: AppTextStyle.textBase.copyWith(
              color: AppColors.textPrimary, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            itemBuilder: (context, index) => const ItemAlarmWater(),
            separatorBuilder: (context, index) => Gap(12.h),
            itemCount: 10),
      ),
    );
  }
}
