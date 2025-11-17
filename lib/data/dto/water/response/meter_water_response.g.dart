// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meter_water_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MeterWaterResponseImpl _$$MeterWaterResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$MeterWaterResponseImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      meterCode: (json['meterCode'] as num?)?.toInt() ?? 0,
      updateTime: json['updateTime'] as String? ?? "",
      value: json['value'] as String? ?? "",
      state: json['state'] as String? ?? "",
    );

Map<String, dynamic> _$$MeterWaterResponseImplToJson(
        _$MeterWaterResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'meterCode': instance.meterCode,
      'updateTime': instance.updateTime,
      'value': instance.value,
      'state': instance.state,
    };
