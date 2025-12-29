part of 'estatistical_cubit.dart';

@freezed
class EStatisticalState with _$EStatisticalState {
  const factory EStatisticalState({
    required Result<PaginationResponse<LastedLogDataResponse>> resultChart,
    required ChartElectricRequest request,
    required DateTime dateTime,
    required int meterId,
    @Default([]) List<SalesData> loadPowers,
    @Default([]) List<SalesData> thdUa,
    @Default([]) List<SalesData> thdUb,
    @Default([]) List<SalesData> thdUc,
    @Default([]) List<SalesData> thdIa,
    @Default([]) List<SalesData> thdIb,
    @Default([]) List<SalesData> thdIc,
    @Default(true) bool selectThdUa,
    @Default(true) bool selectThdUb,
    @Default(true) bool selectThdUc,
    @Default(true) bool selectThdIa,
    @Default(true) bool selectThdIb,
    @Default(true) bool selectThdIc,
  }) = _StatisticalState;

  factory EStatisticalState.init() => EStatisticalState(
      meterId: 0,
      resultChart: Result(),
      dateTime: DateTime.now(),
      request: const ChartElectricRequest(
        meterId: 0,
        searchType: SearchType.hour,
      ));
}
