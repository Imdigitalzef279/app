import 'package:solar_energy/data/dto/api_response/api_response.dart';
import 'package:solar_energy/data/dto/electric/response/electric_meter_response.dart';
import 'package:solar_energy/data/dto/result/result.dart';
import 'package:solar_energy/data/repositories/electric/electric_repository.dart';
import 'package:solar_energy/data/repositories/base_repository.dart';


class ElectricRepositoryImpl extends BaseRepository implements ElectricRepository{
  @override
  Future<Result<PaginationResponse<ElectricMeter>>> getElectric(int request) async {
    return await callApiPagination(() => api.getElectric(request));
  }

}