import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_account_request.g.dart';

@JsonSerializable()
class RegisterAccountRequest {
  final String userName;
  final String emailAddress;
  final String password;
  final String appName;

  RegisterAccountRequest({
    required this.userName,
    required this.emailAddress,
    required this.password,
    required this.appName,
  });

  factory RegisterAccountRequest.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$RegisterAccountRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$RegisterAccountRequestToJson(this);
}