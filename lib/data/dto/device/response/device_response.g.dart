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
      parentId: (json['parentId'] as num?)?.toInt() ?? 0,
      level: (json['level'] as num?)?.toInt() ?? 0,
      creationTime: json['creationTime'] as String? ?? "",
      gatewayNumber: json['gatewayNumber'] as String? ?? '',
      avatar: json['avatar'] as String? ?? '',
      isFavorite: json['isFavorite'] as bool? ?? false,
      meterType: json['meterType'] == null
          ? const MeterTypeResponse()
          : MeterTypeResponse.fromJson(
              json['meterType'] as Map<String, dynamic>),
      powerStation: json['powerStation'] == null
          ? const PowerStationResponse()
          : PowerStationResponse.fromJson(
              json['powerStation'] as Map<String, dynamic>),
      lastedLogData: json['lastedLogData'] == null
          ? null
          : LastedLogDataResponse.fromJson(
              json['lastedLogData'] as Map<String, dynamic>),
      realtimeLog: json['realtimeLog'] == null
          ? null
          : AtomatLogResponse.fromJson(
              json['realtimeLog'] as Map<String, dynamic>),
      rlyRepSta: (json['rlyRepSta'] as num?)?.toInt() ?? 0,
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
      'parentId': instance.parentId,
      'level': instance.level,
      'creationTime': instance.creationTime,
      'gatewayNumber': instance.gatewayNumber,
      'avatar': instance.avatar,
      'isFavorite': instance.isFavorite,
      'meterType': instance.meterType,
      'powerStation': instance.powerStation,
      'lastedLogData': instance.lastedLogData,
      'realtimeLog': instance.realtimeLog,
      'rlyRepSta': instance.rlyRepSta,
    };
