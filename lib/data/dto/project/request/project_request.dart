import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_request.g.dart';

part 'project_request.freezed.dart';

@freezed
class ProjectRequest with _$ProjectRequest {
  const factory ProjectRequest(
      {@Default('name asc') String sorting,
      @Default(0) int skipCount,
      @Default(10) int maxResultCount}) = _ProjectRequest;

  factory ProjectRequest.fromJson(Map<String, dynamic> json) =>
      _$ProjectRequestFromJson(json);
}
