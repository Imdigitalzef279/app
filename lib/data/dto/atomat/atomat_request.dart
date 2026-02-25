import 'package:freezed_annotation/freezed_annotation.dart';

part 'atomat_request.freezed.dart';

part 'atomat_request.g.dart';

@freezed
class AtomatRequest with _$AtomatRequest {
  const factory AtomatRequest({
    @JsonKey(name: 'breakerSn') required String breakerSn,
    @JsonKey(name: 'fromDate') required String fromDate,
    @JsonKey(name: 'toDate') required String toDate,
  }) = _AtomatRequest;

  factory AtomatRequest.fromJson(Map<String, dynamic> json) =>
      _$AtomatRequestFromJson(json);
}
