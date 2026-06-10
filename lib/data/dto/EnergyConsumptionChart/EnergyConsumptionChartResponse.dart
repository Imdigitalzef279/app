import 'package:freezed_annotation/freezed_annotation.dart';

part 'EnergyConsumptionChartResponse.freezed.dart';
part 'EnergyConsumptionChartResponse.g.dart';

@freezed
class EnergyConsumptionChartResponse
    with _$EnergyConsumptionChartResponse {
  const factory EnergyConsumptionChartResponse({
    @Default([]) List<String> labels,
    @Default([]) List<double> currentPeriodData,
    @Default([]) List<double> previousPeriodData,
  }) = _EnergyConsumptionChartResponse;

  factory EnergyConsumptionChartResponse.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$EnergyConsumptionChartResponseFromJson(json);
}