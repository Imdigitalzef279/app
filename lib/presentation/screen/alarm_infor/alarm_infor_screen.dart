import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/presentation/screen/alarm_infor/widget/current_alarm.dart';
import 'package:solar_energy/presentation/screen/alarm_infor/widget/history_alarm.dart';
import 'package:solar_energy/presentation/screen/alarm_infor/widget/item_alarm.dart';

import '../../../application/constants/app_text_style.dart';

class AlarmInfoScreen extends StatefulWidget {
  const AlarmInfoScreen({
    super.key,
  });

  @override
  State<AlarmInfoScreen> createState() => _AlarmInfoScreenState();
}

class _AlarmInfoScreenState extends State<AlarmInfoScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: const BoxDecoration(
              color: AppColors.white),
          child: TabBar(
              tabs: const <Widget>[
                Tab(
                  text: "Hiện tại",
                ),
                Tab(
                  text: "Trước đó",
                ),
              ],
              controller: _tabController,
              labelStyle: AppTextStyle.textSm.copyWith(color: AppColors.blueEA),
              indicatorColor: AppColors.blueFD,
              unselectedLabelColor: AppColors.grey73,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColors.blueFD.withOpacity(0.5)),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 0,
              dividerColor: Colors.transparent),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              CurrentAlarm(listCurrent: [],),
              HistoryAlarm(listCurrent: [])
            ],
          ),
        )
      ],
    );
  }
}

class ErrorDevice {
  final String? nameError;
  final String? nameFactory;
  final String? procedure;
  final String? idAlarm;
  final String? idError;
  final String? nameDevice;
  final String? typeDevice;
  final String? time;

  const ErrorDevice(
      {this.idAlarm,
      this.idError,
      this.nameDevice,
      this.nameError,
      this.nameFactory,
      this.procedure,
      this.time,
      this.typeDevice});
}
