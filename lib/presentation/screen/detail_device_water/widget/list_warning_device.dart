import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../alarm_water/widget/item_alarm_water.dart';

class ListWarningDevice extends StatefulWidget {
  const ListWarningDevice({super.key});

  @override
  State<ListWarningDevice> createState() => _ListWarningDeviceState();
}

class _ListWarningDeviceState extends State<ListWarningDevice> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            itemBuilder: (context, index) => const ItemAlarmWater(),
            separatorBuilder: (context, index) => Gap(12.h),
            itemCount: 10));
  }
}
