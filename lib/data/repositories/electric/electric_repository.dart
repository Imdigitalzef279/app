import 'package:solar_energy/data/dto/electric/response/electric_meter_response.dart';
import 'package:solar_energy/data/dto/meter/request/meter_request.dart';
import 'package:solar_energy/data/dto/lasted_log_data/response/lasted_log_data_response.dart';

import '../../dto/api_response/api_response.dart';
import '../../dto/meter/response/meter_response.dart';
import '../../dto/result/result.dart';

abstract class ElectricRepository {

  /// API cũ - lấy danh sách electric theo PowerStationId
  Future<Result<PaginationResponse<ElectricMeter>>> getElectric(int request);

  /// Tạo meter mới
  Future<Result<MeterResponse>> createElectricMeter(MeterRequest request);

  /// 🔥 API mới - Lấy log realtime theo meterId
  Future<Result<LastedLogDataResponse>> getTopLogMeter({
    required int meterId,
  });
}
