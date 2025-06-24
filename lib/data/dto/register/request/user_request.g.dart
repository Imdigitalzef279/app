// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserRequestImpl _$$UserRequestImplFromJson(Map<String, dynamic> json) =>
    _$UserRequestImpl(
      userName: json['userName'] as String? ?? "",
      name: json['name'] as String? ?? "",
      surname: json['surname'] as String? ?? "",
      email: json['email'] as String? ?? "",
      phoneNumber: json['phoneNumber'] as String? ?? "",
      isActive: json['isActive'] as bool? ?? true,
      lockoutEnabled: json['lockoutEnabled'] as bool? ?? true,
      roleNames: (json['roleNames'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const ["USER"],
      password: json['password'] as String? ?? "",
      extraProperties: json['extraProperties'] == null
          ? const ExtraProperties(projectId: 21)
          : ExtraProperties.fromJson(
              json['extraProperties'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserRequestImplToJson(_$UserRequestImpl instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'name': instance.name,
      'surname': instance.surname,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'isActive': instance.isActive,
      'lockoutEnabled': instance.lockoutEnabled,
      'roleNames': instance.roleNames,
      'password': instance.password,
      'extraProperties': instance.extraProperties,
    };
