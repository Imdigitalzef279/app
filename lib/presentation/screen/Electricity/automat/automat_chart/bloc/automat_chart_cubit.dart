import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../../application/enums/chart_range.dart';
import '../../../../../../data/data_sources/api/api_client.dart';
import '../../../../../../data/dto/atomat/atomat_chart/breaker_chart_response.dart';

class AutomatChartCubit extends Cubit<List<BreakerChartResponse>> {

  final _api = GetIt.instance<ApiClient>();

  AutomatChartCubit() : super([]);

  Future<void> loadChart(String meterCode, ChartRange range) async {

    try {

      emit([]);

      final result = await _api.getBreakerChartData(
        meterCode,
      );

      emit(result);

    } catch (e) {

      print("Chart error $e");

      emit([]);

    }

  }

}