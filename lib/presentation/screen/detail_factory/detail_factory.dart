import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/enums/electric_type.dart';
import 'package:solar_energy/domain/arguments/electric_meter/electric_meter_argument.dart';
import 'package:solar_energy/gen/assets.gen.dart';
import 'package:solar_energy/presentation/screen/Electricity/electricity_screen.dart';
import 'package:solar_energy/presentation/screen/device/devices_screen.dart';
import 'package:solar_energy/presentation/screen/overview/overview_screen.dart';
import 'package:solar_energy/presentation/screen/statistical/statistical_screen.dart';

import '../Electricity/bloc/electric_cubit.dart';
import '../device/bloc/device_cubit.dart';
import '../overview/bloc/overview_cubit.dart';

class DetailFactoryScreen extends StatefulWidget {
  const DetailFactoryScreen({super.key, required this.type});

  final ElectricMeterArgument type;

  @override
  State<DetailFactoryScreen> createState() => _DetailFactoryScreenState();
}

class _DetailFactoryScreenState extends State<DetailFactoryScreen> {
  late int indexPage;
  late DeviceCubit cubit;
  int meterId = 0;

  @override
  void initState() {
    super.initState();
    indexPage = (0);
    cubit = BlocProvider.of<DeviceCubit>(context);
    _loadInitialMeterId();
  }

  Future<void> _loadInitialMeterId() async {
    meterId = await cubit.getDeviceFirst(
        powerStationId: widget.type.project.id, type: widget.type.type);
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
                width: 20,
                height: 20,
                colorFilter:
                    const ColorFilter.mode(Colors.blue, BlendMode.srcIn)),
            icon: Assets.icons.overviewLine.svg(
                width: 20,
                height: 20,
                colorFilter:
                    const ColorFilter.mode(AppColors.grey73, BlendMode.srcIn)),
            label: "",
          ),
          NavigationDestination(
            selectedIcon: Assets.icons.chartArea.svg(
                width: 20,
                height: 20,
                colorFilter:
                    const ColorFilter.mode(Colors.blue, BlendMode.srcIn)),
            icon: Assets.icons.chartAreaLine.svg(
                width: 20,
                height: 20,
                colorFilter:
                    const ColorFilter.mode(AppColors.grey73, BlendMode.srcIn)),
            label: "",
          ),
          NavigationDestination(
            selectedIcon: Assets.icons.computerSpeaker.svg(
                width: 20,
                height: 20,
                colorFilter:
                    const ColorFilter.mode(Colors.blue, BlendMode.srcIn)),
            icon: Assets.icons.computerSpeakerLine.svg(
                width: 20,
                height: 20,
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
        return widget.type.type == ElectricType.saveElectric
            ? BlocProvider(
                create: (context) => ElectricCubit(),
                child: ElectricityScreen(
                  project: widget.type.project,
                ),
              )
            : BlocProvider(
                create: (context) => OverviewCubit(),
                child: OverViewScreen(
                  type: widget.type.type,
                  project: widget.type.project,
                ));
      case 1:
        return StatisticalScreen(argument: widget.type, meterId: meterId);
      case 2:
        return BlocProvider(
            create: (context) => DeviceCubit(),
            child: DevicesScreen(
              argument: widget.type,
            ));
      default:
        return const SizedBox();
    }
  }
}
