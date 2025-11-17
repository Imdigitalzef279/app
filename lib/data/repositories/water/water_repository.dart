import 'package:solar_energy/data/dto/result/result.dart';

import '../../dto/water/request/meter_water_request.dart';
import '../../dto/water/response/meter_water_response.dart';

abstract class WaterRepository {
  Future<Result<List<MeterWaterResponse>>> getMeterValues(MeterWaterRequest request);
}