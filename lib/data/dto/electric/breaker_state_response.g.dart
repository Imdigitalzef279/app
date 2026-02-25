// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breaker_state_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BreakerStateResponseImpl _$$BreakerStateResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$BreakerStateResponseImpl(
      gatewaySn: json['gatewaySn'] as String? ?? '',
      breakerSn: json['breakerSn'] as String? ?? '',
      addr: json['addr'] as String? ?? '',
      state: json['state'] as String? ?? '',
      rlySta: (json['rlySta'] as num?)?.toInt() ?? 0,
      rlyRepSta: (json['rlyRepSta'] as num?)?.toInt() ?? 0,
      lockSta: (json['lockSta'] as num?)?.toInt() ?? 0,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$BreakerStateResponseImplToJson(
        _$BreakerStateResponseImpl instance) =>
    <String, dynamic>{
      'gatewaySn': instance.gatewaySn,
      'breakerSn': instance.breakerSn,
      'addr': instance.addr,
      'state': instance.state,
      'rlySta': instance.rlySta,
      'rlyRepSta': instance.rlyRepSta,
      'lockSta': instance.lockSta,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
