import 'package:get_it/get_it.dart';
import '../../data_sources/api/api_client.dart';
import '../../dto/meter_config/request/meter_config_request.dart';
import '../../dto/meter_config/response/meter_config_response.dart';
import 'meter_config_repository.dart';

class MeterConfigRepositoryImpl implements MeterConfigRepository {
  final _api = GetIt.instance<ApiClient>();

  @override
  Future<List<MeterConfigResponse>> getConfigs(int meterId) {
    return _api.getMeterConfigByMeterId(meterId);
  }

  @override
  Future<MeterConfigResponse> saveConfig(
      MeterConfigRequest request) async {

    print("====== POST METER CONFIG ======");
    print("BODY: ${request.toJson()}");

    try {
      final res = await _api.createMeterConfig(request);

      print("====== RESPONSE SUCCESS ======");
      print(res.toJson());

      return res;

    } catch (e) {
      print("====== RESPONSE ERROR ======");
      print(e);
      rethrow;
    }
  }
}