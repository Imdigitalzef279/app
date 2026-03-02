import 'package:get_it/get_it.dart';
import 'package:solar_energy/data/data_sources/api/api_client.dart';
import 'package:solar_energy/data/dto/api_response/api_response.dart';
import 'package:solar_energy/data/dto/atomat/atomat_log_response.dart';
import 'package:solar_energy/data/repositories/atomat_repo/atomat_repository.dart';
import 'package:solar_energy/data/repositories/base_repository.dart';

class AtomatRepositoryImpl extends BaseRepository
    implements AtomatRepository {

  final _api = GetIt.instance<ApiClient>();

  @override
  Future<PaginationResponse<AtomatLogResponse>> getBreakerLog(
      String breakerSn,
      ) async {
    try {
      final response = await _api.getBreakerLog(breakerSn);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}