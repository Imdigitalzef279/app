// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_electric_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChartElectricRequestImpl _$$ChartElectricRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$ChartElectricRequestImpl(
      meterId: (json['MeterId'] as num).toInt(),
      searchType: $enumDecode(_$SearchTypeEnumMap, json['Type']),
      fromDate: json['FromDate'] as String?,
      toDate: json['ToDate'] as String?,
      skipCount: (json['SkipCount'] as num?)?.toInt() ?? 0,
      maxResultCount: json['MaxResultCount'] as String? ?? "0x7fffffff",
    );

Map<String, dynamic> _$$ChartElectricRequestImplToJson(
        _$ChartElectricRequestImpl instance) =>
    <String, dynamic>{
      'MeterId': instance.meterId,
      'Type': _$SearchTypeEnumMap[instance.searchType]!,
      'FromDate': instance.fromDate,
      'ToDate': instance.toDate,
      'SkipCount': instance.skipCount,
      'MaxResultCount': instance.maxResultCount,
    };

const _$SearchTypeEnumMap = {
  SearchType.hour: 'HOUR',
  SearchType.day: 'DAY',
  SearchType.month: 'MONTH',
};
