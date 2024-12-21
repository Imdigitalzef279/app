import 'package:dio/dio.dart';
import 'package:solar_energy/application/enums/storages_key.dart';
import 'package:solar_energy/data/data_sources/storage/shared_preferences/shared_preferences_helper.dart';
import 'package:solar_energy/di.dart';

class ApiInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final sharePreferences = getIt<SharedPreferencesHelper>();

    final userToken =
        await sharePreferences.getStringValue(StoragesKey.accessToken);
    if (userToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $userToken';
    }
    return super.onRequest(options, handler);
  }
}
