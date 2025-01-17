import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_energy/data/repositories/auth/auth_repository.dart';
import 'package:solar_energy/data/repositories/auth/auth_repository_impl.dart';
import 'package:solar_energy/data/repositories/solar_electric/solar_electric_repository.dart';
import 'package:solar_energy/data/repositories/solar_electric/solar_electric_repository_impl.dart';

import 'data/data_sources/storage/shared_preferences/shared_preferences_helper.dart';
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
}
