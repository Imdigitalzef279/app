// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meter_config_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MeterConfigResponseImpl _$$MeterConfigResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$MeterConfigResponseImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      meterId: (json['meterId'] as num?)?.toInt() ?? 0,
      configKey: json['configKey'] as String? ?? '',
      configValue: json['configValue'] as String? ?? '',
    );

Map<String, dynamic> _$$MeterConfigResponseImplToJson(
        _$MeterConfigResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'meterId': instance.meterId,
      'configKey': instance.configKey,
      'configValue': instance.configValue,
    };
