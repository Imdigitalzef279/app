import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:solar_energy/data/data_sources/api/api_client.dart';
import '../../../../../../data/dto/atomat/atomat_chart/breaker_chart_response.dart';

class AutomatChartCubit extends Cubit<List<BreakerChartResponse>> {
  final _api = GetIt.instance<ApiClient>();

  AutomatChartCubit() : super([]);

  Future<void> loadChart(String breakerSn) async {
    try {
      final result = await _api.getBreakerChartData(breakerSn);
      emit(result);
    } catch (e) {
      emit([]);
    }
  }
}