import 'package:flutter/material.dart';
import 'package:solar_energy/presentation/routes/route_name.dart';
import 'package:solar_energy/presentation/screen/Home/home.dart';
import 'package:solar_energy/presentation/screen/auth/login_screen.dart';
import 'package:solar_energy/presentation/screen/detail_device/detail_device.dart';
import 'package:solar_energy/presentation/screen/detail_factory/detail_factory.dart';
import 'package:solar_energy/presentation/screen/device/devices_screen.dart';
import 'package:solar_energy/presentation/screen/general_device/general_device_screen.dart';
import 'package:solar_energy/presentation/screen/overview/overview_screen.dart';
import 'package:solar_energy/presentation/screen/statistical/statistical_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    const initialWidget = LoginScreen();
    Widget routeWidget = initialWidget;
    final arguments = routeSettings.arguments;

    switch (routeSettings.name) {
      case RouteName.homeScreen:
        routeWidget = const HomeWidget();
        break;
      case RouteName.loginScreen:
        routeWidget = const LoginScreen();
        break;
      case RouteName.statistical:
        routeWidget = const DetailFactoryScreen();
        break;
      case RouteName.overview:
        routeWidget = arguments != null
            ? OverViewScreen(
                check: arguments as bool,
              )
            : const OverViewScreen();
        break;
      case RouteName.statisticalScreen:
        routeWidget = const StatisticalScreen();
        break;
      case RouteName.deviceScreen:
        routeWidget = const DevicesScreen();
        break;
      case RouteName.factoryDetail:
        routeWidget = const DetailFactoryScreen();
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
