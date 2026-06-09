import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_project_request.freezed.dart';
part 'create_project_request.g.dart';

@freezed
class CreateProjectRequest with _$CreateProjectRequest {
  const factory CreateProjectRequest({
    required String name,
    String? code,
    String? description,
  }) = _CreateProjectRequest;

  factory CreateProjectRequest.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$CreateProjectRequestFromJson(json);
}