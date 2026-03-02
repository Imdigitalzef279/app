import 'package:solar_energy/data/dto/api_response/api_response.dart';
import 'package:solar_energy/data/dto/atomat/atomat_log_response.dart';

abstract class AtomatRepository {
  Future<PaginationResponse<AtomatLogResponse>> getBreakerLog(
      String breakerSn,
      );
}