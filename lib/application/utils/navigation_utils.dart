import 'package:flutter/material.dart';

class NavigatorUtils {
  static RouteObserver<ModalRoute<dynamic>> navigatorObserver = RouteObserver<ModalRoute<dynamic>>();

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}