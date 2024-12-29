import 'package:freezed_annotation/freezed_annotation.dart';

part 'solar_electric_response.g.dart';

part 'solar_electric_response.freezed.dart';

@freezed
class SolarElectricResponse with _$SolarElectricResponse {
  const factory SolarElectricResponse({
    @Default(0) double gridPower,
    @Default(0) double loadPower,
    @Default(0) double productionPower,
    @Default(0) double productionParam,
    @Default(0) double loadParam,
    DateTime? timeUpdated,
  }) = _SolarElectricResponse;

  factory SolarElectricResponse.fromJson(Map<String, dynamic> json) =>
      _$SolarElectricResponseFromJson(json);
}
