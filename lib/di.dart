import 'dart:io';

import 'package:dio/io.dart';
import 'package:get_it/get_it.dart';
import 'package:solar_energy/data/repositories/atomat_repo/atomat_repository.dart';
import 'package:solar_energy/data/repositories/atomat_repo/atomat_repository_impl.dart';
import 'package:solar_energy/data/repositories/auth/auth_repository.dart';
import 'package:solar_energy/data/repositories/auth/auth_repository_impl.dart';
import 'package:solar_energy/data/repositories/cbs/cbs_repository.dart';
import 'package:solar_energy/data/repositories/cbs/cbs_repository_impl.dart';
import 'package:solar_energy/data/repositories/device/device_repository.dart';
import 'package:solar_energy/data/repositories/device/device_repository_impl.dart';
import 'package:solar_energy/data/repositories/electric/electric_repository.dart';
import 'package:solar_energy/data/repositories/project/project_repository.dart';
import 'package:solar_energy/data/repositories/project/project_repository_impl.dart';
import 'package:solar_energy/data/repositories/solar_electric/solar_electric_repository.dart';
import 'package:solar_energy/data/repositories/solar_electric/solar_electric_repository_impl.dart';
import 'package:solar_energy/data/repositories/water/water_repository.dart';
import 'package:solar_energy/data/repositories/water/water_repository_impl.dart';
import 'application/configs/env_configs.dart';
import 'application/utils/navigation_utils.dart';
import 'data/data_sources/mcb/mcb_mock_datasource.dart';
import 'data/data_sources/mcb/mcb_remote_datasource.dart';
import 'data/data_sources/storage/shared_preferences/shared_preferences_helper.dart';
import 'data/repositories/breaker/breaker_repository.dart';
import 'data/repositories/electric/electric_repository_impl.dart';
import 'data/repositories/email/email_repository.dart';
import 'data/repositories/mcb_repository_impl.dart';
import 'data/repositories/meter_config/meter_config_repository.dart';
import 'data/repositories/meter_config/meter_config_repository_impl.dart';
import 'data/repositories/register/register_repository.dart';
import 'data/repositories/register/register_repository_impl.dart';
import 'package:dio/dio.dart';
import 'data/repositories/switch_log/switch_log_repository.dart';
import 'data/repositories/switch_log/switch_log_repository_impl.dart';
import 'domain/mcb/repositories/mcb_repository.dart';
import 'data/data_sources/api/api_client.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  print("🔥 BASE URL: ${EnvConfigs.baseUrl}");
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: EnvConfigs.baseUrl,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = getIt<SharedPreferencesHelper>();
          final token = await prefs.getAccessToken();

          print("=== REQUEST ===");
          print("URL: ${options.uri}");
          print("METHOD: ${options.method}");
          print("BODY: ${options.data}");
          print("TOKEN: $token");

          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },
        onError: (e, handler) async {
          if (e.response?.statusCode == 401) {
            final prefs = getIt<SharedPreferencesHelper>();
            await prefs.removeAccessToken();

            NavigatorUtils.navigatorKey.currentState
                ?.pushNamedAndRemoveUntil(
              '/login',
                  (route) => false,
            );
          }

          return handler.next(e);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
      ),
    );

    return dio;
  });
  // shared preferences
  getIt.registerLazySingleton<SharedPreferencesHelper>(
      () => SharedPreferencesHelper());
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  getIt.registerLazySingleton<SolarElectricRepository>(
      () => SolarElectricRepositoryIml());
  getIt.registerLazySingleton<DeviceRepository>(() => DeviceRepositoryImpl());
  getIt.registerLazySingleton<EmailRepository>(
        () => EmailRepository(),
  );
  getIt.registerLazySingleton<ProjectRepository>(() => ProjectRepositoryImpl());
  getIt.registerLazySingleton<ElectricRepository>(() => ElectricRepositoryImpl());
  getIt.registerLazySingleton<RegisterRepository>(() => RegisterRepositoryImpl());
  getIt.registerLazySingleton<CbsRepository>(
        () => CbsRepositoryImpl(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<WaterRepository>(() => WaterRepositoryImpl());
  getIt.registerLazySingleton<AtomatRepository>(() => AtomatRepositoryImpl());
  // MCB Datasource
  getIt.registerLazySingleton<McbMockDatasource>(
        () => McbMockDatasource(),
  );

  getIt.registerLazySingleton<McbRemoteDatasource>(
        () => McbRemoteDatasource(getIt<Dio>()),
  );

// MCB Repository
  getIt.registerLazySingleton<McbRepository>(
        () => McbRepositoryImpl(
      mock: getIt<McbMockDatasource>(),
      remote: getIt<McbRemoteDatasource>(),
    ),
  );
  getIt.registerLazySingleton<SwitchLogRepository>(
        () => SwitchLogRepositoryImpl(getIt<Dio>()),
  );
  getIt.registerLazySingleton<ApiClient>(
        () => ApiClient(getIt<Dio>()),
  );
  GetIt.instance.registerLazySingleton<MeterConfigRepository>(
        () => MeterConfigRepositoryImpl(),
  );
  getIt.registerLazySingleton<BreakerRepository>(
        () => BreakerRepository(getIt<Dio>()),
  );
}
