// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_meter_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AlarmMeterResponseImpl _$$AlarmMeterResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AlarmMeterResponseImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      status: (json['status'] as num?)?.toInt() ?? 0,
      meter: json['meterDto'] == null
          ? const MeterResponse()
          : MeterResponse.fromJson(json['meterDto'] as Map<String, dynamic>),
      alarmConfig: json['alarmConfigDto'] == null
          ? const AlarmConfigResponse()
          : AlarmConfigResponse.fromJson(
              json['alarmConfigDto'] as Map<String, dynamic>),
      message: json['message'] as String? ?? '',
      reason: json['reason'] as String? ?? '',
      creationTime: json['creationTime'] == null
          ? null
          : DateTime.parse(json['creationTime'] as String),
      resolvedTime: json['resolvedTime'] == null
          ? null
          : DateTime.parse(json['resolvedTime'] as String),
    );

Map<String, dynamic> _$$AlarmMeterResponseImplToJson(
        _$AlarmMeterResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'meterDto': instance.meter,
      'alarmConfigDto': instance.alarmConfig,
      'message': instance.message,
      'reason': instance.reason,
      'creationTime': instance.creationTime?.toIso8601String(),
      'resolvedTime': instance.resolvedTime?.toIso8601String(),
    };
