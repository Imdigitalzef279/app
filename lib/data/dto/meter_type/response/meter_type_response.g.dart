// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meter_type_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MeterTypeResponseImpl _$$MeterTypeResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$MeterTypeResponseImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      code: json['code'] as String? ?? '',
      storeParam: json['storeParam'] as String? ?? '',
      status: (json['status'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$MeterTypeResponseImplToJson(
        _$MeterTypeResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'storeParam': instance.storeParam,
      'status': instance.status,
    };
