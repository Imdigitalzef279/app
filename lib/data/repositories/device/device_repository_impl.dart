import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:solar_energy/data/dto/api_response/api_response.dart';
import 'package:solar_energy/data/dto/device/response/device_response.dart';
import 'package:solar_energy/data/dto/meter/request/meter_request.dart';
import 'package:solar_energy/data/dto/meter/response/meter_response.dart';
import 'package:solar_energy/data/dto/result/result.dart';
import 'package:solar_energy/data/repositories/base_repository.dart';
import 'package:solar_energy/data/repositories/device/device_repository.dart';

import '../../../application/enums/load_status.dart';
import '../../data_sources/api/api_client.dart';
import '../../dto/atomat/atomat_log_response.dart';

class DeviceRepositoryImpl extends BaseRepository implements DeviceRepository {

  final _api = GetIt.instance<ApiClient>();

  @override
  Future<Result<List<DeviceResponse>>> getSolarElectric(int powerStationID) async {
    final result = Result<List<DeviceResponse>>();

    try {
      final List<DeviceResponse> data =
      await _api.getDevices(powerStationID);
      print("===== DEVICE LIST =====");
      for (var d in data) {
        print(d.toJson());
      }
      print("=======================");

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
  @override
  Future<Result<List<AtomatLogResponse>>> getBreakerLog(String breakerSn) async {

    final result = Result<List<AtomatLogResponse>>();

    try {

      final response = await _api.getBreakerLog(breakerSn);

      return result.copyWith(
        data: response.data ?? [],
        status: LoadStatus.success,
      );

    } catch (e) {

      return result.copyWith(
        status: LoadStatus.failure,
        error: e.toString(),
      );

    }
  }

  @override
  Future<Result<MeterResponse>> createElectricMeter(MeterRequest request) async {
    final result = Result<MeterResponse>();
    try{
      final MeterResponse data = await _api.createMeter(request);
      return result.copyWith(data: data, status: LoadStatus.success);
    }catch (e){
      if (e is DioException && e.error is ErrorResponse) {
        final error = e.error as ErrorResponse;
        return result.copyWith(
            status: LoadStatus.failure, error: error.message);
      }
      return result.copyWith(status: LoadStatus.failure, error: e.toString());
    }
  }
}
