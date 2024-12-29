import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/application/enums/electric_type.dart';
import 'package:solar_energy/presentation/screen/overview/widget/currently_widget.dart';
import 'package:solar_energy/presentation/screen/overview/widget/header_widget.dart';

class OverViewScreen extends StatefulWidget {
  const OverViewScreen({super.key, required this.type});

  final ElectricType type;

  @override
  State<OverViewScreen> createState() => _OverViewScreenState();
}

class _OverViewScreenState extends State<OverViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.blueFB,
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu, size: 16.sp),
          )
        ],
      ),
      backgroundColor: AppColors.greyFB,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWidget(type: widget.type),
            const CurrentlyWidget(),
          ],
        ),
      ),
    );
  }
}
