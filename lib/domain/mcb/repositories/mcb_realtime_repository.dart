import '../entities/chart_data_entity.dart';
import '../entities/mcb_entity.dart';

abstract class McbRealtimeRepository {
  Future<McbEntity> getRealtime(String deviceId);

  Future<List<ChartDataEntity>> getHistory({
    required String deviceId,
    required DateTime from,
    required DateTime to,
    required String type,
  });

  Future<void> control({
    required String deviceId,
    required String action,
  });
}
