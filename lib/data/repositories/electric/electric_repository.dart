import 'package:solar_energy/data/dto/electric/response/electric_meter_response.dart';

import '../../dto/api_response/api_response.dart';
import '../../dto/result/result.dart';

abstract class ElectricRepository {
  Future<Result<PaginationResponse<ElectricMeter>>> getElectric(int request);
}
