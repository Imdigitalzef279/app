import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/presentation/screen/device/widget/item_device.dart';

class DevicesScreen extends StatefulWidget {
  const DevicesScreen({super.key});

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
              padding: EdgeInsets.only(left: 4.sp),
              child: Icon(Icons.arrow_back_ios, size: 16.sp)),
        ),
        title: Text(
          "Thien son",
          style: AppTextStyle.textBase.copyWith(
              color: AppColors.textPrimary, fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: AppColors.greyFB,
      body: SafeArea(
        child: ListView.separated(
            padding: EdgeInsets.all(12.sp),
            itemBuilder: (context, index) => const ItemDevice(),
            separatorBuilder: (context, index) => Gap(12.sp),
            itemCount: 10),
      ),
    );
  }
}
