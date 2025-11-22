import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/application/enums/load_status.dart';
import 'package:solar_energy/data/data_sources/api/api_client.dart';
import 'package:solar_energy/data/dto/api_response/api_response.dart';
import 'package:solar_energy/data/dto/result/result.dart';
import 'package:solar_energy/di.dart';

class BaseRepository {
  final api = getIt.get<ApiClient>();

  Future<Result<T>> callApi<T>(Future<T> Function() apiCallBack) async {
    final result = Result<T>();
    try {
      final T data = await apiCallBack();
      if (data != null) {
        return result.copyWith(data: data, status: LoadStatus.success);
      }
      return result.copyWith(status: LoadStatus.failure, error: "");
    } catch (e) {
      if (e is TimeoutException) {
        return result.copyWith(
          status: LoadStatus.failure,
          error: LocalizationsUtils.localizations.unstable_connection,
        );
      }

      // socket or connection error
      if (e is DioException) {
        if (e.error is SocketException ||
            e.type == DioExceptionType.unknown ||
            e.type == DioExceptionType.connectionError) {
          return result.copyWith(
            status: LoadStatus.failure,
            error: LocalizationsUtils.localizations.unstable_connection,
          );
        }

        // error response (404,...)
        if (e.error is ErrorResponse) {
          final error = e.error as ErrorResponse;
          return result.copyWith(
            status: LoadStatus.failure,
            error: error.message,
          );
        }
      }

      // fallback
      return result.copyWith(
        status: LoadStatus.failure,
        error: LocalizationsUtils.localizations.an_error_occurred,
      );
    }
  }

  Future<Result<PaginationResponse<T>>> callApiPagination<T>(
      Future<PaginationResponse<T>> Function() apiCallBack) async {
    final result = Result<PaginationResponse<T>>();
    try {
      final PaginationResponse<T> data = await apiCallBack();
      return result.copyWith(data: data, status: LoadStatus.success);
    } catch (e) {
      if (e is TimeoutException) {
        return result.copyWith(
          status: LoadStatus.failure,
          error: LocalizationsUtils.localizations.unstable_connection,
        );
      }

      // socket or connection error
      if (e is DioException) {
        if (e.error is SocketException ||
            e.type == DioExceptionType.unknown ||
            e.type == DioExceptionType.connectionError) {
          return result.copyWith(
            status: LoadStatus.failure,
            error: LocalizationsUtils.localizations.unstable_connection,
          );
        }

        // error response (404,...)
        if (e.error is ErrorResponse) {
          final error = e.error as ErrorResponse;
          return result.copyWith(
            status: LoadStatus.failure,
            error: error.message,
          );
        }
      }

      // fallback
      return result.copyWith(
        status: LoadStatus.failure,
        error: LocalizationsUtils.localizations.an_error_occurred,
      );
    }
  }
}
