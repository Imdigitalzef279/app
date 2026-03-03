import 'package:flutter/material.dart';
import 'package:solar_energy/presentation/screen/app.dart';

import 'application/configs/env_configs.dart';
import 'di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvConfigs.init();
  configureDependencies();
  runApp(const MyApp());
  print("BASE URL: ${EnvConfigs.baseUrl}");
}
