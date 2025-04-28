part of 'estatistical_cubit.dart';

@freezed
class EStatisticalState with _$EStatisticalState {
  const factory EStatisticalState({
    required Result<PaginationResponse<LastedLogDataResponse>> resultChart,
    required ChartElectricRequest request,
    required DateTime dateTime,
    required int meterId,
    @Default([]) List<SalesData> loadPowers,
  }) = _StatisticalState;

  factory EStatisticalState.init() => EStatisticalState(
      meterId: 0,
      resultChart: Result(),
      dateTime: DateTime.now(),
      request: const ChartElectricRequest(meterId: 0, searchType: SearchType.hour,));
}
