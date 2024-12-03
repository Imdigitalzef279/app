
import 'package:flutter/material.dart';
import 'package:solar_energy/presentation/routes/route_name.dart';
import 'package:solar_energy/presentation/screen/Home/home.dart';
import 'package:solar_energy/presentation/screen/auth/login_screen.dart';
import 'package:solar_energy/presentation/screen/detail_device/detail_device.dart';
import 'package:solar_energy/presentation/screen/detail_factory/detail_factory.dart';


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