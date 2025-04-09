import 'package:solar_energy/data/dto/api_response/api_response.dart';
import 'package:solar_energy/data/dto/device/request/device_request.dart';
import 'package:solar_energy/data/dto/device/response/device_response.dart';
import 'package:solar_energy/data/dto/result/result.dart';

abstract class DeviceRepository {
  Future<Result<List<DeviceResponse>>> getSolarElectric(
      int powerStationID);
}
