import 'package:dio/dio.dart';

import '../../../application/enums/storages_key.dart';
import '../../../di.dart';
import '../storage/shared_preferences/shared_preferences_helper.dart';


class ApiInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final sharePreferences = getIt<SharedPreferencesHelper>();

    final userToken = await sharePreferences.getStringValue(StoragesKey.accessToken);
    if (userToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $userToken';
    }

    return super.onRequest(options, handler);
  }
}