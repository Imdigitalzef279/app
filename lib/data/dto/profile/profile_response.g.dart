// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileResponseImpl _$$ProfileResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ProfileResponseImpl(
      userName: json['userName'] as String? ?? "",
      email: json['email'] as String? ?? "",
      name: json['name'] as String? ?? "",
      surname: json['surname'] as String? ?? "",
      phoneNumber: json['phoneNumber'] as String? ?? "",
    );

Map<String, dynamic> _$$ProfileResponseImplToJson(
        _$ProfileResponseImpl instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'email': instance.email,
      'name': instance.name,
      'surname': instance.surname,
      'phoneNumber': instance.phoneNumber,
    };
