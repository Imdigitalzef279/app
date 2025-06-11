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
    options.headers['Cookie'] =
        '.AspNetCore.Antiforgery._hALYwUpIpc=CfDJ8Pl3MwmQoUZGuLTC_mFq3ii0wvT1YOC1BPG-zMikW7fKt6JUTbZZyfMzpJc2FcJ3Fb30PiWkLqdhkd9Jd3q_Wm3ygvNetydmcsT--RhkzvvjsC_7KPbJU3eQ_lLARNG0S9-p73DJ80mYZH7u0ujOEmE; idsrv.session=3868CCA6483661015485150B571CBB32; XSRF-TOKEN=CfDJ8Pl3MwmQoUZGuLTC_mFq3igQBpSRRumIuQ-CtMEqMZrz28DQ1rBrR_FT3My2jiuNfJ9FHQRVNUlJ4cf55qLKdah5KM1wYuOLi07ymNPBCnFvZSxFPrLFQJw6lpdADui1OmYDkswhcvHzCRf6E8jM8bJYjXPP_L482b6tk0MwXfnUAvsvrIA1leMmPNHdDG0etA; .AspNetCore.Identity.Application=CfDJ8Pl3MwmQoUZGuLTC_mFq3ijXv5z5QgBJ4LH4PgY6nnAThAY4swfgG69hsDxst21N2UcBdgWi4b-3mX0gjVHAtNF1K7D6F199uGmccR-QwbOOQSa7Vk0AdmmdB30A7igLPR_kc2jAmzeOXyDfmp_r3J-icpgOQpgLb1zTK3C7ENzlGQjtYtQY0VRHtqMmIegvHX3NbglzwrWCJyTRrUwcIpPi_QiGuEj00pN0eqqe9OFGHsXJdcDIoAgZCzUJgkTwXYx8ZNcRmR-6e7sUgaGqYmlso7iSdbqEDAygW3HQ_2l5rYhmYtwHiIfp6FgoO9ZD6BtFvJOlazBorQcVg5VPYJEWON76sd5v4AzqN9NWklRlOj2dDikkjVTZposrzBU10HoR5pxl6OOarZZw5Mwd16xxKp3El8sruXkOiQoPzpMH4uUKpOqpP1YjrMMCu_mUrrXlhCYDLMLiYBMtaiXmrvZDlohmyFoM3vzxfuq4bihy20JX2SeTnmnJtNObn2XUfz6pl0nBrbDlLkUqO3-HAeATfZ5CvhbnyV3aM0TO3Lo6CtjKXabwF9Xk9zpgXScJ5LhNpFdFIR6jMuCGmRr60hWAgIsmW6CJcpRR_upyOyKh8Y3nt9UCZR-Yx-xFVwrSqTP1OjE-RUNBFsK3u55IxTGW1JKIc23CQLciKZzKMHF39X8qM7Xnac2MHoIPPEa8XVaocUZ87OPnxiPmG7algVcD7STQ_UE2t4Jmfb26a7IdetUhQO7HwepZ8p6AsAdr3fAkZycr29qaGUz63rhff3b8xGDMOwadd0M0l1TlNxluqxEROPlNl7PjLBIqssadQMiKfmu3Qf3ISy95doP1Uk6iziFySQ_h7SqfEcZWRAfv41bx8jK_1sUibaKyQMLiBtQbb-V0bNzysOue9Lg8vuDN7yZBzc18-g7oprHhGkHD0yyQwMtgAGBljJRho8xnVHwP0vWjGbjnEfFFjt40SgqHYAWVsCfcgS_hlcy-vLrzV9RDdwZdTkG4WNn0kKn0Sd4XhOl6n7Rw18ku_I8gy19CIRMDAgNhTWSpOHVkg5yFOP8ad7I-2zPLSfPCJOLukV16_GAHTWVmOS-85tf1auaVdFoAAk0KqY2b_GvKOq40yPGSk7os9SCb86n6nia7JIQwqV8jRS-iPTHOSi9T_0Yt-IGoc9UzrRHvnsNtlAM4LPBDLrzR5PtH_G6paa4-gYwY9EeaGQNt89VkwpKTsRjgaLXx_3s5Aq1sxNJTU9lK';
    options.headers['X-Requested-With'] = 'XMLHttpRequest';
    options.headers['RequestVerificationToken'] =
        'CfDJ8Pl3MwmQoUZGuLTC_mFq3igQBpSRRumIuQ-CtMEqMZrz28DQ1rBrR_FT3My2jiuNfJ9FHQRVNUlJ4cf55qLKdah5KM1wYuOLi07ymNPBCnFvZSxFPrLFQJw6lpdADui1OmYDkswhcvHzCRf6E8jM8bJYjXPP_L482b6tk0MwXfnUAvsvrIA1leMmPNHdDG0etA';
    print('Request URL: ${options.baseUrl}${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;
    int? statusCode;
    if (err.error is RedirectException) {
      final redirectException = err.error as RedirectException;
      if (redirectException.redirects.isNotEmpty) {
        statusCode = redirectException.redirects.first.statusCode;
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
