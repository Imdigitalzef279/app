part of 'statistical_cubit.dart';

@freezed
class StatisticalState with _$StatisticalState {
  const factory StatisticalState({
    required Result<PaginationResponse<SolarElectricResponse>> resultSolar,
    required SolarElectricRequest request,
    required DateTime dateTime,
    @Default(0) double totalGridPower,
    @Default(0) double totalProductionPower,
    @Default(0) double totalLoadPower,
    @Default([]) List<ChartData> listOutput,
    @Default([]) List<ChartData> listUsed,
    @Default([]) List<SalesData> gridPowers,
    @Default([]) List<SalesData> productionPowers,
    @Default([]) List<SalesData> loadPowers,
  }) = _StatisticalState;

  factory StatisticalState.init() => StatisticalState(
      resultSolar: Result(),
      dateTime: DateTime.now(),
      request: const SolarElectricRequest(
          powerStationId: 0, searchType: SearchType.hour, searchValue: ''));
}
