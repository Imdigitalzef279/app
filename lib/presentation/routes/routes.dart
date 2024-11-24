
import 'package:flutter/material.dart';
import 'package:solar_energy/presentation/routes/route_name.dart';
import 'package:solar_energy/presentation/screen/Home/home.dart';


class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    const initialWidget = HomeWidget();
    Widget routeWidget = initialWidget;
    final arguments = routeSettings.arguments;

    switch (routeSettings.name) {
      case RouteName.test_app:
        routeWidget = const HomeWidget();
        break;
      default:
        routeWidget = initialWidget;
        break;
    }
    return MaterialPageRoute(
        builder: (_) => routeWidget, settings: routeSettings);
  }

}