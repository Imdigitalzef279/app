// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solar_electric_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SolarElectricRequestImpl _$$SolarElectricRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$SolarElectricRequestImpl(
      powerStationId: (json['powerStationId'] as num).toInt(),
      searchType: $enumDecode(_$SearchTypeEnumMap, json['searchType']),
      searchValue: json['searchValue'] as String,
    );

Map<String, dynamic> _$$SolarElectricRequestImplToJson(
        _$SolarElectricRequestImpl instance) =>
    <String, dynamic>{
      'powerStationId': instance.powerStationId,
      'searchType': _$SearchTypeEnumMap[instance.searchType]!,
      'searchValue': instance.searchValue,
    };

const _$SearchTypeEnumMap = {
  SearchType.hour: 'HOUR',
  SearchType.day: 'DAY',
  SearchType.month: 'MONTH',
};
