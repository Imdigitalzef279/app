import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_request.freezed.dart';

part 'auth_request.g.dart';

@freezed
class AuthRequest with _$AuthRequest {
  const factory AuthRequest({
    @JsonKey(name: 'grant_type') required String grantType,
    @JsonKey(name: 'client_id') required String clientId,
    @JsonKey(name: 'username') required String username,
    @JsonKey(name: 'password') required String password,
    @JsonKey(name: 'scope') required String scope,
  }) = _AuthRequest;

  factory AuthRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthRequestFromJson(json);
}
