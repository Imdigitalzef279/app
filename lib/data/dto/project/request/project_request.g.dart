// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectRequestImpl _$$ProjectRequestImplFromJson(Map<String, dynamic> json) =>
    _$ProjectRequestImpl(
      sorting: json['sorting'] as String? ?? 'name asc',
      skipCount: (json['skipCount'] as num?)?.toInt() ?? 0,
      maxResultCount: (json['maxResultCount'] as num?)?.toInt() ?? 10,
    );

Map<String, dynamic> _$$ProjectRequestImplToJson(
        _$ProjectRequestImpl instance) =>
    <String, dynamic>{
      'sorting': instance.sorting,
      'skipCount': instance.skipCount,
      'maxResultCount': instance.maxResultCount,
    };
