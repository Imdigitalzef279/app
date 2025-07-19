import 'package:solar_energy/data/dto/power_station/request/power_station_request.dart';
import 'package:solar_energy/data/dto/power_station/response/power_station_response.dart';

import 'package:solar_energy/data/dto/result/result.dart';

abstract class ProjectRepository {
  Future<Result<List<PowerStationResponse>>> getPowerStation(int projectID);
  Future<Result<PowerStationResponse>> createPowerStation(PowerStationRequest request);
}
