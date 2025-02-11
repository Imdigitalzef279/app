import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_response.g.dart';

part 'project_response.freezed.dart';

@freezed
class ProjectResponse with _$ProjectResponse {
  const factory ProjectResponse({
    @Default(0) int id,
    @Default("") String name,
    @Default("") String info,
    @Default("") String creator,
    DateTime? creationTime,
    @Default("") String lastModifier,
  }) = __$ProjectResponse;

  factory ProjectResponse.fromJson(Map<String, dynamic> json) =>
      _$ProjectResponseFromJson(json);
}
