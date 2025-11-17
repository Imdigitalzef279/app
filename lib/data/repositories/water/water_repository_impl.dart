import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:solar_energy/data/dto/result/result.dart';
import 'package:solar_energy/data/dto/water/request/meter_water_request.dart';
import 'package:solar_energy/data/dto/water/response/meter_water_response.dart';

import 'package:solar_energy/data/repositories/water/water_repository.dart';

import '../../../application/enums/load_status.dart';
import '../../data_sources/api/api_client.dart';
import '../../dto/api_response/api_response.dart';

class WaterRepositoryImpl implements WaterRepository {
  final _api = GetIt.instance<ApiClient>();

  @override
  Future<Result<List<MeterWaterResponse>>> getMeterValues(
      MeterWaterRequest request) async {
    final result = Result<List<MeterWaterResponse>>();
    try {
      final List<MeterWaterResponse> data = await _api.getChartWater(request);
      return result.copyWith(data: data, status: LoadStatus.success);
    } catch (e) {
      if (e is DioException && e.error is ErrorResponse) {
        final error = e.error as ErrorResponse;
        return result.copyWith(
            status: LoadStatus.failure, error: error.message);
      }
      return result.copyWith(status: LoadStatus.failure, error: e.toString());
    }
  }
}
