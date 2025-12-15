// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cbs_meter_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CbsMeterRequestImpl _$$CbsMeterRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CbsMeterRequestImpl(
      stationId: (json['stationId'] as num).toInt(),
      typeId: (json['typeId'] as num?)?.toInt() ?? 81,
      apiKey: json['apiKey'] as String? ?? "KRAPOWER_KEY",
      cbsList: (json['cbsList'] as List<dynamic>?)
              ?.map((e) => CbsItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CbsMeterRequestImplToJson(
        _$CbsMeterRequestImpl instance) =>
    <String, dynamic>{
      'stationId': instance.stationId,
      'typeId': instance.typeId,
      'apiKey': instance.apiKey,
      'cbsList': instance.cbsList,
    };
