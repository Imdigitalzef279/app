// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'electric_meter_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ElectricMeterImpl _$$ElectricMeterImplFromJson(Map<String, dynamic> json) =>
    _$ElectricMeterImpl(
      meter: json['meter'] == null
          ? const MeterResponse()
          : MeterResponse.fromJson(json['meter'] as Map<String, dynamic>),
      lastedLogData: json['lastedLogData'] == null
          ? const LastedLogDataResponse()
          : LastedLogDataResponse.fromJson(
              json['lastedLogData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ElectricMeterImplToJson(_$ElectricMeterImpl instance) =>
    <String, dynamic>{
      'meter': instance.meter,
      'lastedLogData': instance.lastedLogData,
    };
