// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaginationResponseImpl<T> _$$PaginationResponseImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$PaginationResponseImpl<T>(
      data: (json['items'] as List<dynamic>?)?.map(fromJsonT).toList(),
      totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$PaginationResponseImplToJson<T>(
  _$PaginationResponseImpl<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'items': instance.data?.map(toJsonT).toList(),
      'totalCount': instance.totalCount,
    };
