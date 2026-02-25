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
import 'package:solar_energy/presentation/screen/device/add_device_screen.dart';

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
  int indexPage = 0;
  late DeviceCubit cubit;
  late List<bool> _tabLoaded;
  int meterId = 0;

  @override
  void initState() {
    super.initState();
    _tabLoaded = [true, false, false];
    cubit = BlocProvider.of<DeviceCubit>(context);
    _loadInitialMeterId();
  }

  Future<void> _loadInitialMeterId() async {
    meterId = await cubit.getDeviceFirst(
      powerStationId: widget.type.project.id,
      type: widget.type.type,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      floatingActionButton: _buildAddDeviceButton(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  // ================= FLOATING BUTTON =================

  Widget? _buildAddDeviceButton() {
    if (indexPage != 2) return null;

    return FloatingActionButton.extended(
      backgroundColor: Colors.blue,
      icon: const Icon(Icons.add, color: Colors.white),
      label: const Text(
        'Thêm thiết bị',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddDeviceScreen(
              powerStationId: widget.type.project.id,
              meterId: meterId,
            ),
          ),
        );

        if (result == true) {
          cubit.getDevices(
            powerStationId: widget.type.project.id,
            type: widget.type.type,
          );
        }
      },
    );
  }

  // ================= BODY =================

  Widget _buildBody() {
    return IndexedStack(
      index: indexPage,
      children: [
        _tabLoaded[0]
            ? (widget.type.type == ElectricType.saveElectric
            ? BlocProvider(
          create: (_) => ElectricCubit(),
          child: ElectricityScreen(project: widget.type.project),
        )
            : BlocProvider(
          create: (_) => OverviewCubit(),
          child: OverViewScreen(
            type: widget.type.type,
            project: widget.type.project,
          ),
        ))
            : const SizedBox(),

        _tabLoaded[1]
            ? StatisticalScreen(
          argument: widget.type,
          meterId: meterId,
        )
            : const SizedBox(),


        _tabLoaded[2]
            ? DevicesScreen(argument: widget.type)
            : const SizedBox(),
      ],
    );
  }

  // ================= BOTTOM BAR =================

  Widget _buildBottomBar() {
    return NavigationBar(
      selectedIndex: indexPage,
      onDestinationSelected: (index) {
        setState(() {
          indexPage = index;
          _tabLoaded[index] = true;
        });
      },
      indicatorColor: Colors.blue.withOpacity(0.2),
      destinations: [
        NavigationDestination(
          selectedIcon: Assets.icons.overview.svg(
            width: 20,
            height: 20,
            colorFilter:
            const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
          ),
          icon: Assets.icons.overviewLine.svg(
            width: 20,
            height: 20,
            colorFilter:
            const ColorFilter.mode(AppColors.grey73, BlendMode.srcIn),
          ),
          label: '',
        ),
        NavigationDestination(
          selectedIcon: Assets.icons.chartArea.svg(
            width: 20,
            height: 20,
            colorFilter:
            const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
          ),
          icon: Assets.icons.chartAreaLine.svg(
            width: 20,
            height: 20,
            colorFilter:
            const ColorFilter.mode(AppColors.grey73, BlendMode.srcIn),
          ),
          label: '',
        ),
        NavigationDestination(
          selectedIcon: Assets.icons.computerSpeaker.svg(
            width: 20,
            height: 20,
            colorFilter:
            const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
          ),
          icon: Assets.icons.computerSpeakerLine.svg(
            width: 20,
            height: 20,
            colorFilter:
            const ColorFilter.mode(AppColors.grey73, BlendMode.srcIn),
          ),
          label: '',
        ),
      ],
    );
  }
}
