import '../../data_sources/api/api_client.dart';
import '../../dto/alarm/response/alarm_response.dart';

class AlarmRepository {
  final ApiClient api;

  AlarmRepository(this.api);

  Future<List<AlarmResponse>> getAlarms() async {
    final res = await api.getActiveAlarms();
    return res.data ?? [];
  }
}