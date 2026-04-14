// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_config_meter_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AlarmConfigMeterResponseImpl _$$AlarmConfigMeterResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AlarmConfigMeterResponseImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      meterId: (json['meterId'] as num?)?.toInt() ?? 0,
      meterCode: json['meterCode'] as String? ?? '',
      thresholdValue: json['thresholdValue'] as String? ?? '',
      thresholdType: json['thresholdType'] as String? ?? '',
    );

Map<String, dynamic> _$$AlarmConfigMeterResponseImplToJson(
        _$AlarmConfigMeterResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'meterId': instance.meterId,
      'meterCode': instance.meterCode,
      'thresholdValue': instance.thresholdValue,
      'thresholdType': instance.thresholdType,
    };
