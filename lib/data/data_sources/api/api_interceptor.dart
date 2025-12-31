import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/application/enums/storages_key.dart';
import 'package:solar_energy/application/utils/navigation_utils.dart';
import 'package:solar_energy/data/data_sources/storage/shared_preferences/shared_preferences_helper.dart';
import 'package:solar_energy/data/dto/api_response/api_response.dart';
import 'package:solar_energy/di.dart';
import 'package:solar_energy/presentation/common_widgets/app_toast.dart';
import 'package:solar_energy/presentation/routes/route_name.dart';

class ApiInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final prefs = getIt<SharedPreferencesHelper>();
    final token = await prefs.getStringValue(StoragesKey.accessToken);

    //final isApiRequest = options.uri.host.contains(options.baseUrl);

    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    debugPrint('➡️ ${options.method} ${options.uri}');
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;

    handleHttpError(err);

    if (response != null) {
      final Map<String, dynamic> data = response.data;
      if (data.containsKey('error')) {
        final ErrorResponse errorResponse =
            ErrorResponse.fromJson(data['error']);
        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: errorResponse, // Attach ErrorResponse
          ),
        );
        return;
      }
    }
    super.onError(err, handler);
  }

  void handleHttpError(DioException err) {
    final status = err.response?.statusCode;

    if (status == null) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final sharedPreferences = GetIt.instance<SharedPreferencesHelper>();

      switch (status) {
        case 302:
          AppToast.dismissAll();
          AppToast.showToastNotify(
            title: LocalizationsUtils.localizations.loginExpired,
          );
          sharedPreferences.removeAccessToken();
          NavigatorUtils.navigatorKey.currentState?.pushNamedAndRemoveUntil(
            RouteName.loginScreen,
            (route) => false,
          );
          break;
        case 400:
          AppToast.showToastNotify(
            title: LocalizationsUtils.localizations.badRequest,
          );
          break;

        case 401:
          AppToast.dismissAll();
          AppToast.showToastNotify(
            title: LocalizationsUtils.localizations.loginExpired,
          );
          sharedPreferences.removeAccessToken();
          NavigatorUtils.navigatorKey.currentState?.pushNamedAndRemoveUntil(
            RouteName.loginScreen,
            (route) => false,
          );
          break;

        case 403:
          AppToast.showToastNotify(
            title: LocalizationsUtils.localizations.forbidden,
          );
          break;

        case 404:
          AppToast.showToastNotify(
            title: LocalizationsUtils.localizations.notFound,
          );
          break;

        case 408:
          AppToast.showToastNotify(
            title: LocalizationsUtils.localizations.requestTimeout,
          );
          break;

        case 409:
          AppToast.showToastNotify(
            title: LocalizationsUtils.localizations.conflictError,
          );
          break;

        case 422:
          AppToast.showToastNotify(
            title: LocalizationsUtils.localizations.unprocessable,
          );
          break;

        case 429:
          AppToast.showToastNotify(
            title: LocalizationsUtils.localizations.tooManyRequests,
          );
          break;

        case 500:
          AppToast.showToastNotify(
            title: LocalizationsUtils.localizations.serverError,
          );
          break;

        case 503:
          AppToast.showToastNotify(
            title: LocalizationsUtils.localizations.serverUnavailable,
          );
          break;

        default:
          AppToast.showToastNotify(
            title: LocalizationsUtils.localizations.unknownError,
          );
          break;
      }
    });
  }
}
