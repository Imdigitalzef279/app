// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cbs_meter_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CbsMeterRequestImpl _$$CbsMeterRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CbsMeterRequestImpl(
      gatewaySn: json['gatewaySn'] as String,
      breakerSn: json['breakerSn'] as String,
      addr: json['addr'] as String,
      commandValue: json['commandValue'] as String,
      createdBy: json['createdBy'] as String? ?? "admin",
      isForce: json['isForce'] as bool,
    );

Map<String, dynamic> _$$CbsMeterRequestImplToJson(
        _$CbsMeterRequestImpl instance) =>
    <String, dynamic>{
      'gatewaySn': instance.gatewaySn,
      'breakerSn': instance.breakerSn,
      'addr': instance.addr,
      'commandValue': instance.commandValue,
      'createdBy': instance.createdBy,
      'isForce': instance.isForce,
    };
