import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solar_energy/application/enums/search_type.dart';

part 'solar_electric_request.g.dart';

part 'solar_electric_request.freezed.dart';

@freezed
class SolarElectricRequest with _$SolarElectricRequest {
  const factory SolarElectricRequest({
    required int powerStationId,
    required SearchType searchType,
    required String searchValue,
  }) = _SolarElectricRequest;

  factory SolarElectricRequest.fromJson(Map<String, dynamic> json) =>
      _$SolarElectricRequestFromJson(json);

}
