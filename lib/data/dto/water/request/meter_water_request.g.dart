// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meter_water_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MeterWaterRequestImpl _$$MeterWaterRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$MeterWaterRequestImpl(
      detailId: (json['detailId'] as num).toInt(),
      powerStationId: (json['powerStationId'] as num).toInt(),
      fromDate: json['fromDate'] as String,
      toDate: json['toDate'] as String,
    );

Map<String, dynamic> _$$MeterWaterRequestImplToJson(
        _$MeterWaterRequestImpl instance) =>
    <String, dynamic>{
      'detailId': instance.detailId,
      'powerStationId': instance.powerStationId,
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
    };
