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
  Future<int> setBreakerMaintenance(CbsMeterRequest request) {
    return _apiClient.setBreakerMaintenance(request);
  }

}