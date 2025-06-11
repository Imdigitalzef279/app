import 'package:solar_energy/application/enums/electric_type.dart';
import 'package:solar_energy/data/dto/power_station/response/power_station_response.dart';

import '../../../data/dto/project/response/project_response.dart';

class ElectricMeterArgument {
  final ElectricType type;
  final PowerStationResponse project;

  const ElectricMeterArgument({required this.type, required this.project});
}
