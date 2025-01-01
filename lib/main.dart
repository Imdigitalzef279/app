import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solar_energy/presentation/screen/app.dart';

import 'application/configs/env_configs.dart';
import 'data/data_sources/api/api_client_provider.dart';
import 'di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  await EnvConfigs.init();
  ApiClientProvider.init();

  runApp(const MyApp());
}
