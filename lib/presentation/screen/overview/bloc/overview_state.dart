part of 'overview_cubit.dart';

@freezed
class OverviewState with _$OverviewState {
  const factory OverviewState(
      {required Result<PaginationResponse<SolarElectricResponse>> resultSolar,
        @Default(0) double totalGridPower,
        @Default(0) double totalProductionPower,
        @Default(0) double totalLoadPower,
        @Default(0) double maxGridPower,
        @Default(0) double maxProductionPower}) = _OverviewState;

  factory OverviewState.init() =>
      OverviewState(resultSolar: Result());
}
