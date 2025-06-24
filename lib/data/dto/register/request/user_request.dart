import 'package:freezed_annotation/freezed_annotation.dart';

import 'extra_properties.dart';

part 'user_request.freezed.dart';

part 'user_request.g.dart';

@freezed
class UserRequest with _$UserRequest {
  const factory UserRequest({
    @Default("") @JsonKey(name: 'userName') String userName,
    @Default("") @JsonKey(name: 'name') String name,
    @Default("") @JsonKey(name: 'surname') String surname,
    @Default("") @JsonKey(name: 'email') String email,
    @Default("") @JsonKey(name: 'phoneNumber') String phoneNumber,
    @Default(true) @JsonKey(name: 'isActive') bool isActive,
    @Default(true) @JsonKey(name: 'lockoutEnabled') bool lockoutEnabled,
    @Default(["USER"]) @JsonKey(name: 'roleNames') List<String> roleNames,
    @Default("") @JsonKey(name: 'password') String password,
    @Default(ExtraProperties(projectId: 21))
    @JsonKey(name: 'extraProperties')
    ExtraProperties extraProperties,
  }) = _UserRequest;

  factory UserRequest.fromJson(Map<String, dynamic> json) =>
      _$UserRequestFromJson(json);
}
