// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lasted_log_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LastedLogDataResponseImpl _$$LastedLogDataResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$LastedLogDataResponseImpl(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      updateTime: json['UPDATE_TIME'] == null
          ? null
          : DateTime.parse(json['UPDATE_TIME'] as String),
      meterName: json['METER_NAME'] as String? ?? '',
      status: (json['STATUS'] as num?)?.toInt() ?? 0,
      paramPf: json['PARAM_PF'] as String? ?? '',
      paramEpi: json['PARAM_EPI'] as String? ?? '',
      paramEpe: json['PARAM_EPE'] as String? ?? '',
      paramEql: json['PARAM_EQL'] as String? ?? '',
      paramEqc: json['PARAM_EQC'] as String? ?? '',
      paramUa: json['PARAM_UA'] as String? ?? '',
      paramUb: json['PARAM_UB'] as String? ?? '',
      paramUc: json['PARAM_UC'] as String? ?? '',
      paramIa: json['PARAM_IA'] as String? ?? '',
      paramIb: json['PARAM_IB'] as String? ?? '',
      paramIc: json['PARAM_IC'] as String? ?? '',
      paramPa: json['PARAM_PA'] as String? ?? '',
      paramPb: json['PARAM_PB'] as String? ?? '',
      paramPc: json['PARAM_PC'] as String? ?? '',
      paramP: json['PARAM_P'] as String? ?? '',
      paramQa: json['PARAM_QA'] as String? ?? '',
      paramQb: json['PARAM_QB'] as String? ?? '',
      paramQc: json['PARAM_QC'] as String? ?? '',
      paramQ: json['PARAM_Q'] as String? ?? '',
      thd: json['THD'] as String? ?? '',
      ct: json['CT'] as String? ?? '',
    );

Map<String, dynamic> _$$LastedLogDataResponseImplToJson(
        _$LastedLogDataResponseImpl instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'UPDATE_TIME': instance.updateTime?.toIso8601String(),
      'METER_NAME': instance.meterName,
      'STATUS': instance.status,
      'PARAM_PF': instance.paramPf,
      'PARAM_EPI': instance.paramEpi,
      'PARAM_EPE': instance.paramEpe,
      'PARAM_EQL': instance.paramEql,
      'PARAM_EQC': instance.paramEqc,
      'PARAM_UA': instance.paramUa,
      'PARAM_UB': instance.paramUb,
      'PARAM_UC': instance.paramUc,
      'PARAM_IA': instance.paramIa,
      'PARAM_IB': instance.paramIb,
      'PARAM_IC': instance.paramIc,
      'PARAM_PA': instance.paramPa,
      'PARAM_PB': instance.paramPb,
      'PARAM_PC': instance.paramPc,
      'PARAM_P': instance.paramP,
      'PARAM_QA': instance.paramQa,
      'PARAM_QB': instance.paramQb,
      'PARAM_QC': instance.paramQc,
      'PARAM_Q': instance.paramQ,
      'THD': instance.thd,
      'CT': instance.ct,
    };
