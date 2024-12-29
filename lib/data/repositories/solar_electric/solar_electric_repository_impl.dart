import 'package:solar_energy/data/dto/api_response/api_response.dart';
import 'package:solar_energy/data/dto/result/result.dart';
import 'package:solar_energy/data/dto/solar_electric/request/solar_electric_request.dart';
import 'package:solar_energy/data/dto/solar_electric/response/solar_electric_response.dart';
import 'package:solar_energy/data/repositories/base_repository.dart';
import 'package:solar_energy/data/repositories/solar_electric/solar_electric_repository.dart';

class SolarElectricRepositoryIml extends BaseRepository
    implements SolarElectricRepository {
  @override
  Future<Result<PaginationResponse<SolarElectricResponse>>> getSolarElectric(
      SolarElectricRequest request) {
    return callApiPagination(() => api.getSolarElectric(request));
  }
}
