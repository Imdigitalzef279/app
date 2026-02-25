import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:solar_energy/data/dto/api_response/api_response.dart';
import 'package:solar_energy/data/dto/electric/response/electric_meter_response.dart';
import 'package:solar_energy/data/dto/meter/request/meter_request.dart';
import 'package:solar_energy/data/dto/meter/response/meter_response.dart';
import 'package:solar_energy/data/dto/result/result.dart';
import 'package:solar_energy/data/dto/lasted_log_data/response/lasted_log_data_response.dart';
import 'package:solar_energy/data/repositories/electric/electric_repository.dart';
import 'package:solar_energy/data/repositories/base_repository.dart';

import '../../../application/enums/load_status.dart';
import '../../data_sources/api/api_client.dart';

class ElectricRepositoryImpl extends BaseRepository
    implements ElectricRepository {

  final _api = GetIt.instance<ApiClient>();

  // ============================================================
  // GET ELECTRIC LIST (API CŨ - with-log theo powerStationId)
  // ============================================================

  @override
  Future<Result<PaginationResponse<ElectricMeter>>> getElectric(
      int request) async {
    return await callApiPagination(
          () => api.getElectric(request),
    );
  }

  // ============================================================
  // CREATE ELECTRIC METER
  // ============================================================

  @override
  Future<Result<MeterResponse>> createElectricMeter(
      MeterRequest request) async {

    final result = Result<MeterResponse>();

    try {
      final MeterResponse data =
      await _api.createMeter(request);

      return result.copyWith(
        data: data,
        status: LoadStatus.success,
      );

    } catch (e) {

      if (e is DioException && e.error is ErrorResponse) {
        final error = e.error as ErrorResponse;
        return result.copyWith(
          status: LoadStatus.failure,
          error: error.message,
        );
      }

      return result.copyWith(
        status: LoadStatus.failure,
        error: e.toString(),
      );
    }
  }

  // ============================================================
  // 🔥 GET REALTIME LOG (API WEB ĐANG DÙNG)
  // GET /api/app/log-meter/top-log-meter?meterId=xxx
  // ============================================================

  @override
  Future<Result<LastedLogDataResponse>> getTopLogMeter({
    required int meterId,
  }) async {

    final result = Result<LastedLogDataResponse>();

    try {

      // ✅ GỌI METHOD RETROFIT ĐÃ KHAI BÁO TRONG ApiClient
      final data = await _api.getTopLogMeter(meterId);

      return result.copyWith(
        data: data,
        status: LoadStatus.success,
      );

    } catch (e) {

      if (e is DioException && e.error is ErrorResponse) {
        final error = e.error as ErrorResponse;

        return result.copyWith(
          status: LoadStatus.failure,
          error: error.message,
        );
      }

      return result.copyWith(
        status: LoadStatus.failure,
        error: e.toString(),
      );
    }
  }
}
