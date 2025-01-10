import 'package:solar_energy/data/dto/api_response/api_response.dart';
import 'package:solar_energy/data/dto/device/request/device_request.dart';
import 'package:solar_energy/data/dto/device/response/device_response.dart';
import 'package:solar_energy/data/dto/result/result.dart';
import 'package:solar_energy/data/repositories/base_repository.dart';
import 'package:solar_energy/data/repositories/device/device_repository.dart';

class DeviceRepositoryImpl extends BaseRepository implements DeviceRepository {
  @override
  Future<Result<PaginationResponse<DeviceResponse>>> getSolarElectric(
      DeviceRequest request) async {
    return callApiPagination(() => api.getDevices(request));
  }
}
