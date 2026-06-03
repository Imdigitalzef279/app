// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_account_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterAccountRequest _$RegisterAccountRequestFromJson(
        Map<String, dynamic> json) =>
    RegisterAccountRequest(
      userName: json['userName'] as String,
      emailAddress: json['emailAddress'] as String,
      password: json['password'] as String,
      appName: json['appName'] as String,
    );

Map<String, dynamic> _$RegisterAccountRequestToJson(
        RegisterAccountRequest instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'emailAddress': instance.emailAddress,
      'password': instance.password,
      'appName': instance.appName,
    };
