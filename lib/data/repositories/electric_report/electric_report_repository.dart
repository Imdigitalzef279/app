import '../../data_sources/api/api_client.dart';
import '../../dto/electric_report/electric_report_response.dart';

class ElectricReportRepository {
  final ApiClient api;

  ElectricReportRepository(this.api);

  Future<ElectricReport> getElectricReport({
    required int meterId,
    required DateTime from,
    required DateTime to,
  }) async {
    return await api.getElectricReport(
      meterId,
      from.toIso8601String(),
      to.toIso8601String(),
    );
  }
}