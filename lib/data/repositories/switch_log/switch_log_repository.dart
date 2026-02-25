import '../aptomat_log/switch_log_model.dart';

abstract class SwitchLogRepository {
  Future<List<SwitchLogModel>> getLogs(String gatewaySn);
}