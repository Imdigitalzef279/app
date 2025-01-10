// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeviceRequestImpl _$$DeviceRequestImplFromJson(Map<String, dynamic> json) =>
    _$DeviceRequestImpl(
      powerStationId: (json['powerStationId'] as num).toInt(),
      sorting: json['sorting'] as String? ?? 'name asc',
      skipCount: (json['skipCount'] as num?)?.toInt() ?? 0,
      maxResultCount: (json['maxResultCount'] as num?)?.toInt() ?? 10,
    );

Map<String, dynamic> _$$DeviceRequestImplToJson(_$DeviceRequestImpl instance) =>
    <String, dynamic>{
      'powerStationId': instance.powerStationId,
      'sorting': instance.sorting,
      'skipCount': instance.skipCount,
      'maxResultCount': instance.maxResultCount,
    };
