import 'package:easy_localization/easy_localization.dart';

import '../../data_sources/api/api_client.dart';
import '../../dto/electric_report/electric_report_response.dart';
import '../../dto/energy_report/energy_report_response.dart';

class EnergyRepository {
  final ApiClient api;

  EnergyRepository(this.api);
  Future<ElectricReport> getElectricReport({
    required int meterId,
    required DateTime from,
    required DateTime to,
  }) async {

    final fromStr = DateFormat("yyyy-MM-dd").format(from);
    final toStr = DateFormat("yyyy-MM-dd").format(to);

    final res = await api.getElectricReport(
      meterId,
      fromStr,
      toStr,
    );

    return res;
  }
  Future<List<EnergyReportResponse>> getByDateRange({
    required int stationId,
    required int deviceId,
    required DateTime from,
    required DateTime to,
  }) async {

    final fromStr = DateFormat("yyyy-MM-dd").format(from);
    final toStr = DateFormat("yyyy-MM-dd").format(to);

    final res = await api.getEnergyReportByDateRange(
      stationId,
      deviceId,
      fromStr,
      toStr,
    );

    return res;
  }
}