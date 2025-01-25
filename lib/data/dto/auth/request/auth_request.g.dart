// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthRequestImpl _$$AuthRequestImplFromJson(Map<String, dynamic> json) =>
    _$AuthRequestImpl(
      grantType: json['grant_type'] as String,
      clientId: json['client_id'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      scope: json['scope'] as String,
    );

Map<String, dynamic> _$$AuthRequestImplToJson(_$AuthRequestImpl instance) =>
    <String, dynamic>{
      'grant_type': instance.grantType,
      'client_id': instance.clientId,
      'username': instance.username,
      'password': instance.password,
      'scope': instance.scope,
    };
