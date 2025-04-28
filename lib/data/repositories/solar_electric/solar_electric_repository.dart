import 'package:solar_energy/data/dto/api_response/api_response.dart';
import 'package:solar_energy/data/dto/electric/chart_electric/chart_electric_request.dart';
import 'package:solar_energy/data/dto/lasted_log_data/response/lasted_log_data_response.dart';
import 'package:solar_energy/data/dto/result/result.dart';
import 'package:solar_energy/data/dto/solar_electric/request/solar_electric_request.dart';
import 'package:solar_energy/data/dto/solar_electric/response/solar_electric_response.dart';

abstract class SolarElectricRepository {
  Future<Result<PaginationResponse<SolarElectricResponse>>> getSolarElectric(
      SolarElectricRequest request);

  Future<Result<PaginationResponse<LastedLogDataResponse>>> getChartElectric(
      ChartElectricRequest request);
}
