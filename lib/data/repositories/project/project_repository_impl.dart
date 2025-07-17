import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:solar_energy/data/data_sources/api/api_client.dart';
import 'package:solar_energy/data/dto/api_response/api_response.dart';
import 'package:solar_energy/data/dto/power_station/request/power_station_request.dart';
import 'package:solar_energy/data/dto/power_station/response/power_station_response.dart';
import 'package:solar_energy/data/dto/result/result.dart';
import 'package:solar_energy/data/repositories/base_repository.dart';
import 'package:solar_energy/data/repositories/project/project_repository.dart';

import '../../../application/enums/load_status.dart';

class ProjectRepositoryImpl extends BaseRepository
    implements ProjectRepository {

  final _api = GetIt.instance<ApiClient>();

  @override
  Future<Result<List<PowerStationResponse>>> getPowerStation(int projectID) async {
    final result = Result<List<PowerStationResponse>>();
    try{
      final List<PowerStationResponse> data = await _api.getPowerStation(projectID);
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

  @override
  Future<Result<PowerStationResponse>> createPowerStation(PowerStationRequest request) async {
    final result = Result<PowerStationResponse>();
    try{
      final PowerStationResponse data = await _api.createPowerStation(request);
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
