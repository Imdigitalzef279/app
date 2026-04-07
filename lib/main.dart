import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_energy/presentation/screen/app.dart';
import 'package:solar_energy/presentation/screen/device/bloc/device_cubit.dart';
import 'package:solar_energy/presentation/screen/general_device/background/bloc/background_cubit.dart';

import 'application/configs/env_configs.dart';
import 'di.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvConfigs.init();
  configureDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => BackgroundCubit()..load(),
        ),
        BlocProvider(
          create: (_) => DeviceCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );

  print("BASE URL: ${EnvConfigs.baseUrl}");
}