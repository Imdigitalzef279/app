import '../../dto/cbs/request/cbs_meter_request.dart';

abstract class CbsRepository {
  Future<int> sendCbsCommand(CbsMeterRequest request);
}