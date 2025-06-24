import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:solar_energy/application/extensions/extensions.dart';
import 'package:solar_energy/data/data_sources/api/redirect_interceptor.dart';

import '../../../application/configs/env_configs.dart';
import '../../../di.dart';
import 'api_client.dart';
import 'api_interceptor.dart';

class ApiClientProvider {
  static void init({bool forceInit = false}) {
    final dio = Dio();

    dio.options.connectTimeout = const Duration(seconds: 60);
    dio.options.receiveTimeout = const Duration(seconds: 60);

    dio.setFollowRedirects(false);

    final cookieJar = CookieJar();

    dio.interceptors.add(ApiInterceptors());
    //dio.interceptors.add(CookieManager(cookieJar));
    //dio.interceptors.add(RedirectInterceptor(dio));


    // By pass certificate
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client =
            HttpClient(context: SecurityContext(withTrustedRoots: false));
        client.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);

        return client;
      },
    );
    getIt.registerLazySingleton<ApiClient>(
        () => ApiClient(dio, baseUrl: EnvConfigs.baseUrl));
  }
}
