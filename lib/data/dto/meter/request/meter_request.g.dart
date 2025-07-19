// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meter_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MeterRequestImpl _$$MeterRequestImplFromJson(Map<String, dynamic> json) =>
    _$MeterRequestImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      meterTypeId: (json['meterTypeId'] as num?)?.toInt() ?? 2,
      powerStationId: (json['powerStationId'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? "",
      code: json['code'] as String? ?? "",
      description: json['description'] as String? ?? "",
      gatewayNumber: json['gatewayNumber'] as String? ?? "",
      serialNumber: json['serialNumber'] as String? ?? "",
    );

Map<String, dynamic> _$$MeterRequestImplToJson(_$MeterRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'meterTypeId': instance.meterTypeId,
      'powerStationId': instance.powerStationId,
      'name': instance.name,
      'code': instance.code,
      'description': instance.description,
      'gatewayNumber': instance.gatewayNumber,
      'serialNumber': instance.serialNumber,
    };
