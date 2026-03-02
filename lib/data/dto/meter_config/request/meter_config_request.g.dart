// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meter_config_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MeterConfigRequestImpl _$$MeterConfigRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$MeterConfigRequestImpl(
      meterId: (json['meterId'] as num).toInt(),
      configKey: json['configKey'] as String,
      configValue: (json['configValue'] as num).toInt(),
    );

Map<String, dynamic> _$$MeterConfigRequestImplToJson(
        _$MeterConfigRequestImpl instance) =>
    <String, dynamic>{
      'meterId': instance.meterId,
      'configKey': instance.configKey,
      'configValue': instance.configValue,
    };
