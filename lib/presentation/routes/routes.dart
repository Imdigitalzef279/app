import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_energy/application/enums/electric_type.dart';
import 'package:solar_energy/presentation/routes/route_name.dart';
import 'package:solar_energy/presentation/screen/Home/home.dart';
import 'package:solar_energy/presentation/screen/alarm_water/all_alarm_water_screen.dart';
import 'package:solar_energy/presentation/screen/auth/bloc/login_cubit.dart';
import 'package:solar_energy/presentation/screen/auth/login_screen.dart';
import 'package:solar_energy/presentation/screen/detail_device/detail_device.dart';
import 'package:solar_energy/presentation/screen/detail_factory/detail_factory.dart';
import 'package:solar_energy/presentation/screen/device/devices_screen.dart';
import 'package:solar_energy/presentation/screen/general_device/general_device_screen.dart';
import 'package:solar_energy/presentation/screen/manager_water/manager_water_screen.dart';
import 'package:solar_energy/presentation/screen/statistical/statistical_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    Widget initialWidget = BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child: const LoginScreen());
    Widget routeWidget = initialWidget;
    final arguments = routeSettings.arguments;

    switch (routeSettings.name) {
      case RouteName.homeScreen:
        routeWidget = const HomeWidget();
        break;
      case RouteName.loginScreen:
        routeWidget = BlocProvider(
            create: (BuildContext context) => LoginCubit(),
            child: const LoginScreen());
        break;
      case RouteName.statistical:
        routeWidget = DetailFactoryScreen(type: arguments as ElectricType);
        break;
      case RouteName.statisticalScreen:
        routeWidget = const StatisticalScreen();
        break;
      case RouteName.allAlarmWater:
        routeWidget = const AllAlarmWaterScreen();
        break;
      case RouteName.deviceScreen:
        routeWidget = const DevicesScreen();
        break;
      case RouteName.factoryDetail:
        routeWidget = DetailFactoryScreen(type: arguments as ElectricType);
        break;
      case RouteName.managerWater:
        routeWidget = const ManagerWaterScreen();
        break;
      case RouteName.generalDevice:
        routeWidget = const GeneralDeviceScreen();
        break;
      case RouteName.detailDevice:
        routeWidget = const DetailDeviceScreen();
        break;
      default:
        routeWidget = initialWidget;
        break;
    }
    return MaterialPageRoute(
        builder: (_) => routeWidget, settings: routeSettings);
  }
}
