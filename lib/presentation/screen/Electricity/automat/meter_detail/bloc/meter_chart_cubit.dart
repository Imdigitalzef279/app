import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../../application/enums/chart_range.dart';
import '../../../../../../data/data_sources/api/api_client.dart';
import '../../../../../../data/dto/electric/chart_electric/chart_electric_request.dart';
import '../../../../../../data/dto/lasted_log_data/response/lasted_log_data_response.dart';
import 'package:solar_energy/application/enums/search_type.dart';
class MeterChartCubit extends Cubit<List<LastedLogDataResponse>> {

  final _api = GetIt.instance<ApiClient>();

  MeterChartCubit() : super([]);

  Future<void> loadChart(
      int meterId,
      ChartRange range,
      ) async {
    try {

      emit([]);

      final now = DateTime.now();

      final result = await _api.getChartElectric(
        ChartElectricRequest(
          meterId: meterId,
          searchType: _convertRange(range),
          fromDate: now.subtract(const Duration(days: 30)).toIso8601String(),
          toDate: now.toIso8601String(),
        ),
      );

      print("METER ID = $meterId");
      print("COUNT = ${result.data.length}");

      emit(result.data);

    } catch (e) {

      print("Meter chart error: $e");

      emit([]);
    }
  }

}
SearchType _convertRange(ChartRange range) {
  switch (range) {
    case ChartRange.day:
      return SearchType.hour;

    case ChartRange.week:
      return SearchType.day;

    case ChartRange.month:
      return SearchType.day;

    case ChartRange.quarter:
      return SearchType.month;

    case ChartRange.year:
      return SearchType.month;
  }
}