// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'power_station_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PowerStationResponseImpl _$$PowerStationResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$PowerStationResponseImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      projectId: (json['projectId'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      code: json['code'] as String? ?? '',
      storeParam: json['storeParam'] as String? ?? '',
      description: json['description'] as String? ?? '',
      planViewPath: json['planViewPath'] as String? ?? '',
      longitude: json['longitude'] as String? ?? '',
      latitude: json['latitude'] as String? ?? '',
      creator: json['creator'] as String? ?? '',
    );

Map<String, dynamic> _$$PowerStationResponseImplToJson(
        _$PowerStationResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'projectId': instance.projectId,
      'name': instance.name,
      'code': instance.code,
      'storeParam': instance.storeParam,
      'description': instance.description,
      'planViewPath': instance.planViewPath,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'creator': instance.creator,
    };
