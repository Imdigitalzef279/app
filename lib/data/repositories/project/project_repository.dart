import 'package:solar_energy/data/dto/power_station/response/power_station_response.dart';

import 'package:solar_energy/data/dto/result/result.dart';

abstract class ProjectRepository {
  Future<Result<List<PowerStationResponse>>> getPowerStation(int projectID);
}
