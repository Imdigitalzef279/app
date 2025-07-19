// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'power_station_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PowerStationRequestImpl _$$PowerStationRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$PowerStationRequestImpl(
      projectId: (json['projectId'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? "",
      code: json['code'] as String? ?? "",
      description: json['description'] as String? ?? "",
      longitude: json['longitude'] as String? ?? "",
      latitude: json['latitude'] as String? ?? "",
      planViewPath: json['planViewPath'] as String? ?? "",
    );

Map<String, dynamic> _$$PowerStationRequestImplToJson(
        _$PowerStationRequestImpl instance) =>
    <String, dynamic>{
      'projectId': instance.projectId,
      'name': instance.name,
      'code': instance.code,
      'description': instance.description,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'planViewPath': instance.planViewPath,
    };
