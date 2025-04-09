// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeviceResponseImpl _$$DeviceResponseImplFromJson(Map<String, dynamic> json) =>
    _$DeviceResponseImpl(
      meterTypeId: (json['meterTypeId'] as num?)?.toInt() ?? 0,
      id: (json['id'] as num?)?.toInt() ?? 0,
      projectId: (json['projectId'] as num?)?.toInt() ?? 0,
      powerStationId: (json['powerStationId'] as num?)?.toInt() ?? 0,
      status: (json['status'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      code: json['code'] as String? ?? '',
      description: json['description'] as String? ?? '',
      serialNumber: json['serialNumber'] as String? ?? '',
      creator: json['creator'] as String? ?? '',
      creationTime: json['creationTime'] as String? ?? "",
      meterType: json['meterType'] == null
          ? const MeterTypeResponse()
          : MeterTypeResponse.fromJson(
              json['meterType'] as Map<String, dynamic>),
      powerStation: json['powerStation'] == null
          ? const PowerStationResponse()
          : PowerStationResponse.fromJson(
              json['powerStation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DeviceResponseImplToJson(
        _$DeviceResponseImpl instance) =>
    <String, dynamic>{
      'meterTypeId': instance.meterTypeId,
      'id': instance.id,
      'projectId': instance.projectId,
      'powerStationId': instance.powerStationId,
      'status': instance.status,
      'name': instance.name,
      'code': instance.code,
      'description': instance.description,
      'serialNumber': instance.serialNumber,
      'creator': instance.creator,
      'creationTime': instance.creationTime,
      'meterType': instance.meterType,
      'powerStation': instance.powerStation,
    };
