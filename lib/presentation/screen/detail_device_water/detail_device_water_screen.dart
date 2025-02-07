import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_energy/presentation/screen/alarm_water/all_alarm_water_screen.dart';
import 'package:solar_energy/presentation/screen/detail_device_water/widget/list_warning_device.dart';
import 'package:solar_energy/presentation/screen/device_index/device_index_screen.dart';

import '../../../application/constants/app_color.dart';
import '../../../application/constants/app_text_style.dart';
import '../manager_water/bloc/manager_water_cubit.dart';

class DetailDeviceWaterScreen extends StatefulWidget {
  const DetailDeviceWaterScreen({super.key});

  @override
  State<DetailDeviceWaterScreen> createState() => _DetailDeviceWaterScreenState();
}

class _DetailDeviceWaterScreenState extends State<DetailDeviceWaterScreen> with TickerProviderStateMixin{
  late final TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          backgroundColor: AppColors.white,
          scrolledUnderElevation: 0,
          elevation: 0,
          title: Text(
            "100KTL - M2(COM1-12)",
            style: AppTextStyle.textBase.copyWith(
                color: AppColors.textPrimary, fontWeight: FontWeight.w600),
          ),
        ),
      body: SafeArea(child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: const BoxDecoration(
                color: AppColors.white),
            child: TabBar(
                tabs: const <Widget>[
                  Tab(
                    text: "Chỉ số",
                  ),
                  Tab(
                    text: "Cảnh báo",
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
              children: [
              BlocProvider(
                  create: (context) => ManagerWaterCubit(),
                  child: const DeviceIndexScreen()),
                const ListWarningDevice()
              ],
            ),
          )
        ],
      )),
    );
  }
}
