import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:solar_energy/data/dto/cbs/request/cbs_meter_request.dart';
import 'package:solar_energy/data/repositories/cbs/cbs_repository.dart';

import '../../data_sources/api/api_client.dart';

class CbsRepositoryImpl implements CbsRepository{
  final _api = GetIt.instance<ApiClient>();
  @override
  Future<int> sendCbsCommand(CbsMeterRequest request) async {
    try {
      print("===== FINAL REQUEST BODY =====");
      print(request.toJson());
      print("==============================");

      final result = await _api.controlCircuitBreaker(request);

      print("===== SUCCESS RESPONSE =====");
      print(result);
      print("============================");

      return result;
    } on DioException catch (e) {
      print("===== DIO ERROR =====");
      print("STATUS: ${e.response?.statusCode}");
      print("DATA: ${e.response?.data}");
      print("=====================");

      return -1;
    } catch (e) {
      print("===== UNKNOWN ERROR =====");
      print(e);
      return -1;
    }
  }
}