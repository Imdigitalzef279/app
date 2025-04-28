import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solar_energy/application/enums/search_type.dart';

part 'chart_electric_request.g.dart';

part 'chart_electric_request.freezed.dart';

@freezed
class ChartElectricRequest with _$ChartElectricRequest {
  const factory ChartElectricRequest({
    @JsonKey(name: 'MeterId') required int meterId,
    @JsonKey(name: 'Type') required SearchType searchType,
    @JsonKey(name: 'FromDate') String? fromDate,
    @JsonKey(name: 'ToDate') String? toDate,
    @JsonKey(name: 'SkipCount') @Default(0) int skipCount,
    @JsonKey(name: 'MaxResultCount') @Default("0x7fffffff") String maxResultCount,


  }) = _ChartElectricRequest;

  factory ChartElectricRequest.fromJson(Map<String, dynamic> json) =>
      _$ChartElectricRequestFromJson(json);

}
