// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solar_electric_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SolarElectricResponseImpl _$$SolarElectricResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$SolarElectricResponseImpl(
      gridPower: (json['gridPower'] as num?)?.toDouble() ?? 0,
      loadPower: (json['loadPower'] as num?)?.toDouble() ?? 0,
      productionPower: (json['productionPower'] as num?)?.toDouble() ?? 0,
      productionParam: (json['productionParam'] as num?)?.toDouble() ?? 0,
      loadParam: (json['loadParam'] as num?)?.toDouble() ?? 0,
      timeUpdated: json['timeUpdated'] == null
          ? null
          : DateTime.parse(json['timeUpdated'] as String),
    );

Map<String, dynamic> _$$SolarElectricResponseImplToJson(
        _$SolarElectricResponseImpl instance) =>
    <String, dynamic>{
      'gridPower': instance.gridPower,
      'loadPower': instance.loadPower,
      'productionPower': instance.productionPower,
      'productionParam': instance.productionParam,
      'loadParam': instance.loadParam,
      'timeUpdated': instance.timeUpdated?.toIso8601String(),
    };
