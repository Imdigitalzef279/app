// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_$ProjectResponseImpl _$$_$ProjectResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$_$ProjectResponseImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? "",
      info: json['info'] as String? ?? "",
      creator: json['creator'] as String? ?? "",
      creationTime: json['creationTime'] == null
          ? null
          : DateTime.parse(json['creationTime'] as String),
      lastModifier: json['lastModifier'] as String? ?? "",
    );

Map<String, dynamic> _$$_$ProjectResponseImplToJson(
        _$_$ProjectResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'info': instance.info,
      'creator': instance.creator,
      'creationTime': instance.creationTime?.toIso8601String(),
      'lastModifier': instance.lastModifier,
    };
