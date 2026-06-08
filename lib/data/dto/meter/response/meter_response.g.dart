// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meter_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MeterResponseImpl _$$MeterResponseImplFromJson(Map<String, dynamic> json) =>
    _$MeterResponseImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      status: (json['status'] as num?)?.toInt() ?? 0,
      meterType: json['meterType'] == null
          ? const MeterTypeResponse()
          : MeterTypeResponse.fromJson(
              json['meterType'] as Map<String, dynamic>),
      powerStation: json['powerStation'] == null
          ? const PowerStationResponse()
          : PowerStationResponse.fromJson(
              json['powerStation'] as Map<String, dynamic>),
      name: json['name'] as String? ?? '',
      code: json['code'] as String? ?? '',
      description: json['description'] as String? ?? '',
      gatewayNumber: json['gatewayNumber'] as String? ?? '',
      serialNumber: json['serialNumber'] as String? ?? '',
    );

Map<String, dynamic> _$$MeterResponseImplToJson(_$MeterResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'meterType': instance.meterType,
      'powerStation': instance.powerStation,
      'name': instance.name,
      'code': instance.code,
      'description': instance.description,
      'gatewayNumber': instance.gatewayNumber,
      'serialNumber': instance.serialNumber,
    };
