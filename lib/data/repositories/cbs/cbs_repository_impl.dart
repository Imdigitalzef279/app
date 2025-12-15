import 'package:get_it/get_it.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/data/dto/cbs/request/cbs_meter_request.dart';
import 'package:solar_energy/data/repositories/cbs/cbs_repository.dart';

import '../../data_sources/api/api_client.dart';

class CbsRepositoryImpl implements CbsRepository{
  final _api = GetIt.instance<ApiClient>();
  @override
  Future<String> sendCbsCommand(CbsMeterRequest request) async {
    try{
      return await _api.controlCircuitBreaker(request);
    }catch (e){
      return LocalizationsUtils.localizations.an_error_occurred;
    }
  }
}