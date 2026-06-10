// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EnergyConsumptionChartResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EnergyConsumptionChartResponseImpl
    _$$EnergyConsumptionChartResponseImplFromJson(Map<String, dynamic> json) =>
        _$EnergyConsumptionChartResponseImpl(
          labels: (json['labels'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              const [],
          currentPeriodData: (json['currentPeriodData'] as List<dynamic>?)
                  ?.map((e) => (e as num).toDouble())
                  .toList() ??
              const [],
          previousPeriodData: (json['previousPeriodData'] as List<dynamic>?)
                  ?.map((e) => (e as num).toDouble())
                  .toList() ??
              const [],
        );

Map<String, dynamic> _$$EnergyConsumptionChartResponseImplToJson(
        _$EnergyConsumptionChartResponseImpl instance) =>
    <String, dynamic>{
      'labels': instance.labels,
      'currentPeriodData': instance.currentPeriodData,
      'previousPeriodData': instance.previousPeriodData,
    };
