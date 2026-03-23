import 'package:solar_energy/data/dto/device/response/device_response.dart';
import 'package:solar_energy/data/dto/result/result.dart';
import 'package:solar_energy/data/dto/atomat/atomat_log_response.dart';

import '../../dto/meter/request/meter_request.dart';
import '../../dto/meter/response/meter_response.dart';

abstract class DeviceRepository {

  Future<Result<List<DeviceResponse>>> getSolarElectric(int powerStationID);

  Future<Result<MeterResponse>> createElectricMeter(MeterRequest request);

  Future<Result<List<AtomatLogResponse>>> getBreakerLog(String breakerSn);

}