import 'package:solar_energy/data/dto/api_response/api_response.dart';
import 'package:solar_energy/data/dto/device/request/device_request.dart';
import 'package:solar_energy/data/dto/device/response/device_response.dart';
import 'package:solar_energy/data/dto/result/result.dart';

import '../../dto/meter/request/meter_request.dart';
import '../../dto/meter/response/meter_response.dart';

abstract class DeviceRepository {
  Future<Result<List<DeviceResponse>>> getSolarElectric(int powerStationID);
  Future<Result<MeterResponse>> createElectricMeter(MeterRequest request);
}
