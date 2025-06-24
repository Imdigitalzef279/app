import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_energy/data/dto/device/response/device_response.dart';
import 'package:solar_energy/data/repositories/auth/auth_repository.dart';
import 'package:solar_energy/data/repositories/auth/auth_repository_impl.dart';
import 'package:solar_energy/data/repositories/device/device_repository.dart';
import 'package:solar_energy/data/repositories/device/device_repository_impl.dart';
import 'package:solar_energy/data/repositories/electric/electric_repository.dart';
import 'package:solar_energy/data/repositories/project/project_repository.dart';
import 'package:solar_energy/data/repositories/project/project_repository_impl.dart';
import 'package:solar_energy/data/repositories/solar_electric/solar_electric_repository.dart';
import 'package:solar_energy/data/repositories/solar_electric/solar_electric_repository_impl.dart';

import 'data/data_sources/storage/shared_preferences/shared_preferences_helper.dart';
import 'data/repositories/electric/electric_repository_impl.dart';
import 'data/repositories/register/register_repository.dart';
import 'data/repositories/register/register_repository_impl.dart';
import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() {
  getIt.init();

  // shared preferences
  getIt.registerLazySingleton<SharedPreferencesHelper>(
      () => SharedPreferencesHelper());
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  getIt.registerLazySingleton<SolarElectricRepository>(
      () => SolarElectricRepositoryIml());
  getIt.registerLazySingleton<DeviceRepository>(() => DeviceRepositoryImpl());
  getIt.registerLazySingleton<ProjectRepository>(() => ProjectRepositoryImpl());
  getIt.registerLazySingleton<ElectricRepository>(() => ElectricRepositoryImpl());
  getIt.registerLazySingleton<RegisterRepository>(() => RegisterRepositoryImpl());

}
