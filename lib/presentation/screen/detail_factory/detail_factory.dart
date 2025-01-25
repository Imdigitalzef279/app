import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/enums/electric_type.dart';
import 'package:solar_energy/gen/assets.gen.dart';
import 'package:solar_energy/presentation/screen/Electricity/electricity_screen.dart';
import 'package:solar_energy/presentation/screen/device/devices_screen.dart';
import 'package:solar_energy/presentation/screen/overview/overview_screen.dart';
import 'package:solar_energy/presentation/screen/statistical/statistical_screen.dart';

import '../device/bloc/device_cubit.dart';
import '../overview/bloc/overview_cubit.dart';

class DetailFactoryScreen extends StatefulWidget {
  const DetailFactoryScreen({super.key, required this.type});

  final ElectricType type;

  @override
  State<DetailFactoryScreen> createState() => _DetailFactoryScreenState();
}

class _DetailFactoryScreenState extends State<DetailFactoryScreen> {
  late int indexPage;

  @override
  void initState() {
    super.initState();
    indexPage = (0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) {
          setState(() {
            indexPage = index;
          });
        },
        selectedIndex: indexPage,
        backgroundColor: Colors.white,
        indicatorColor: Colors.blue.withOpacity(0.2),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: [
          NavigationDestination(
            selectedIcon: Assets.icons.overview.svg(
                width: 16.w,
                height: 16.w,
                colorFilter:
                    const ColorFilter.mode(Colors.blue, BlendMode.srcIn)),
            icon: Assets.icons.overviewLine.svg(
                width: 16.w,
                height: 16.w,
                colorFilter:
                    const ColorFilter.mode(AppColors.grey73, BlendMode.srcIn)),
            label: "",
          ),
          NavigationDestination(
            selectedIcon: Assets.icons.chartArea.svg(
                width: 16.w,
                height: 16.w,
                colorFilter:
                    const ColorFilter.mode(Colors.blue, BlendMode.srcIn)),
            icon: Assets.icons.chartAreaLine.svg(
                width: 16.w,
                height: 16.w,
                colorFilter:
                    const ColorFilter.mode(AppColors.grey73, BlendMode.srcIn)),
            label: "",
          ),
          NavigationDestination(
            selectedIcon: Assets.icons.computerSpeaker.svg(
                width: 16.w,
                height: 16.w,
                colorFilter:
                    const ColorFilter.mode(Colors.blue, BlendMode.srcIn)),
            icon: Assets.icons.computerSpeakerLine.svg(
                width: 16.w,
                height: 16.w,
                colorFilter:
                    const ColorFilter.mode(AppColors.grey73, BlendMode.srcIn)),
            label: "",
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (indexPage) {
      case 0:
        return widget.type == ElectricType.saveElectric
            ? const ElectricityScreen()
            : BlocProvider(create: (context) => OverviewCubit(),
            child: OverViewScreen(type: widget.type));
      case 1:
        return const StatisticalScreen();
      case 2:
        return BlocProvider(create: (context) => DeviceCubit(),
        child: const DevicesScreen());
      default:
        return const SizedBox();
    }
  }
}
