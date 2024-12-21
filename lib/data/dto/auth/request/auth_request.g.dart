// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthRequestImpl _$$AuthRequestImplFromJson(Map<String, dynamic> json) =>
    _$AuthRequestImpl(
      userName: json['userNameOrEmailAddress'] as String,
      password: json['password'] as String,
      rememberMe: json['rememberMe'] as bool? ?? false,
    );

Map<String, dynamic> _$$AuthRequestImplToJson(_$AuthRequestImpl instance) =>
    <String, dynamic>{
      'userNameOrEmailAddress': instance.userName,
      'password': instance.password,
      'rememberMe': instance.rememberMe,
    };
