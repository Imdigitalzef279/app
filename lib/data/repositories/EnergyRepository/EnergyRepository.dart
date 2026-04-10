import 'package:easy_localization/easy_localization.dart';

import '../../data_sources/api/api_client.dart';
import '../../dto/energy_report/energy_report_response.dart';

class EnergyRepository {
  final ApiClient api;

  EnergyRepository(this.api);

  Future<List<EnergyReportResponse>> getByDateRange({
    required int stationId,
    required int deviceId,
    required DateTime from,
    required DateTime to,
  }) async {

    final res = await api.getEnergyReportByDateRange(
      stationId,
      deviceId,
      DateFormat("yyyy-MM-dd").format(from),
      DateFormat("yyyy-MM-dd").format(to),
    );

    return res;
  }
}