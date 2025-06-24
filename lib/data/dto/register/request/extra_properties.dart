import 'package:freezed_annotation/freezed_annotation.dart';

part 'extra_properties.freezed.dart';

part 'extra_properties.g.dart';

@freezed
class ExtraProperties with _$ExtraProperties {
  const factory ExtraProperties({
    @JsonKey(name: 'ProjectId') required int projectId,
  }) = _ExtraProperties;

  factory ExtraProperties.fromJson(Map<String, dynamic> json) =>
      _$ExtraPropertiesFromJson(json);
}