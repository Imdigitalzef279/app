import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/application/enums/electric_type.dart';
import 'package:solar_energy/gen/assets.gen.dart';
import 'package:solar_energy/presentation/screen/device/bloc/device_cubit.dart';
import 'package:solar_energy/presentation/screen/device_water/device_water_screen.dart';
import 'package:solar_energy/presentation/screen/manager_water/widget/overview_water.dart';

import '../../../data/dto/power_station/response/power_station_response.dart';

class ManagerWaterScreen extends StatefulWidget {
  const ManagerWaterScreen({super.key, required this.station});

  final PowerStationResponse station;

  @override
  State<ManagerWaterScreen> createState() => _ManagerWaterScreenState();
}

class _ManagerWaterScreenState extends State<ManagerWaterScreen> {
  late DeviceCubit _deviceCubit;
  int _futureDeviceId = 0;
  late int indexPage;

  @override
  void initState() {
    super.initState();
    indexPage = 0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _deviceCubit = BlocProvider.of<DeviceCubit>(context);
      _loadInitialMeterId();
    });
  }

  Future<void> _loadInitialMeterId() async {
    final id = await _deviceCubit.getDeviceFirst(
      powerStationId: widget.station.id,
      type: ElectricType.water,
    );
    setState(() {
      _futureDeviceId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyFB,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        title: Text(
          LocalizationsUtils.localizations.water,
          style: AppTextStyle.textBase.copyWith(
              color: AppColors.textPrimary, fontWeight: FontWeight.w600),
        ),
      ),
      bottomNavigationBar: _futureDeviceId != 0
          ? NavigationBar(
              onDestinationSelected: (index) {
                setState(() {
                  indexPage = index;
                });
              },
              selectedIndex: indexPage,
              backgroundColor: Colors.white,
              indicatorColor: Colors.blue.withOpacity(0.2),
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              destinations: const [
                NavigationDestination(
                  selectedIcon: Icon(Icons.home_rounded, color: Colors.blue),
                  icon: Icon(Icons.home_outlined, color: AppColors.grey73),
                  label: "Tổng quan",
                ),
                NavigationDestination(
                  selectedIcon: Icon(Icons.developer_board, color: Colors.blue),
                  icon: Icon(Icons.developer_board_outlined,
                      color: AppColors.grey73),
                  label: "Thiết bị",
                ),
              ],
            )
          : const SizedBox(),
      body: _futureDeviceId == 0
          ? _noDeviceWidget()
          : IndexedStack(
        index: indexPage,
        children: [
          OverviewWater(
            deviceWater: _futureDeviceId,
            stationId: widget.station.id,
          ),
          DeviceWaterScreen(
            stationId: widget.station.id,
          ),
        ],
      ),
    );
  }


  Widget _noDeviceWidget() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32.h, vertical: 32.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(99.r),
          color: AppColors.blueF8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.icons.nonDeviceDisconnected.svg(
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            Text(
              LocalizationsUtils.localizations.no_devices,
              style: AppTextStyle.textSm.copyWith(color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
