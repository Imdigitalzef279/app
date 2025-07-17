import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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
      RequestOptions options, RequestInterceptorHandler handler) async {
    final sharePreferences = getIt<SharedPreferencesHelper>();

    final userToken =
        await sharePreferences.getStringValue(StoragesKey.accessToken);
    if (userToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $userToken';
    }
    print('Request URL: ${options.baseUrl}${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;
    int? statusCode;
    print(response.toString());
    if (err.error is RedirectException) {
      final redirectException = err.error as RedirectException;
      if (redirectException.redirects.isNotEmpty) {
        statusCode = redirectException.redirects.first.statusCode;
        print(statusCode);
      }
    }
    if (response?.statusCode == 400) {
      super.onError(err, handler);
      return;
    }

    if (statusCode == 302) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final sharedPreferences = GetIt.instance<SharedPreferencesHelper>();
        AppToast.dismissAll();
        AppToast.showToastNotify(title: "Phiên đăng nhập đã hết hạn");
        sharedPreferences.removeAccessToken();
        NavigatorUtils.navigatorKey.currentState
            ?.pushNamedAndRemoveUntil(RouteName.loginScreen, (route) => false);
        return;
      });
    }

    if (response?.statusCode != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final sharedPreferences = GetIt.instance<SharedPreferencesHelper>();
        AppToast.dismissAll();
        AppToast.showToastNotify(title: "Phiên đăng nhập đã hết hạn");
        sharedPreferences.removeAccessToken();
        NavigatorUtils.navigatorKey.currentState
            ?.pushNamedAndRemoveUntil(RouteName.loginScreen, (route) => false);
        return;
      });
    }

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

}
