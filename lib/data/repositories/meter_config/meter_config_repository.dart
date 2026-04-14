import '../../dto/meter_config/request/meter_config_request.dart';
import '../../dto/meter_config/response/meter_config_response.dart';

abstract class MeterConfigRepository {
  Future<List<MeterConfigResponse>> getConfigs(int meterId);
  Future<MeterConfigResponse> saveConfig(MeterConfigRequest request);
  Future<void> saveConfigs(List<MeterConfigRequest> configs);
}