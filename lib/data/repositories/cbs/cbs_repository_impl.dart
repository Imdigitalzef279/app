import '../../data_sources/api/api_client.dart';
import '../../dto/cbs/request/cbs_meter_request.dart';
import 'cbs_repository.dart';

class CbsRepositoryImpl implements CbsRepository {

  final ApiClient _apiClient;

  CbsRepositoryImpl(this._apiClient);

  @override
  Future<int> sendCbsCommand(CbsMeterRequest request) {
    return _apiClient.controlCircuitBreaker(request);
  }

  @override
  Future<int> setBreakerMaintenance(CbsMeterRequest request) async {
    try {
      print("=== CALL CBS MAINTENANCE ===");
      print("REQUEST: ${request.toJson()}");

      final res = await _apiClient.setBreakerMaintenance(request);

      final status = res.response.statusCode;
      final data = res.response.data;

      print("STATUS: $status");
      print("DATA: $data");

      if (status != 200) {
        return -1;
      }

      return 1;
    } catch (e) {
      print("=== ERROR CBS ===");
      print(e);
      return -1;
    }
  }
}