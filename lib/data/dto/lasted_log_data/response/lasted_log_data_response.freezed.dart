// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lasted_log_data_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LastedLogDataResponse _$LastedLogDataResponseFromJson(
    Map<String, dynamic> json) {
  return _LastedLogDataResponse.fromJson(json);
}

/// @nodoc
mixin _$LastedLogDataResponse {
  @JsonKey(name: 'ID')
  int get id =>
      throw _privateConstructorUsedError; // @JsonKey(name: 'GATEWAY_ID') @Default(0) double gatewayId,
// @JsonKey(name: 'METER_CODE') @Default(0) double meterCode,
  @JsonKey(name: 'UPDATE_TIME')
  DateTime? get updateTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'METER_NAME')
  String get meterName => throw _privateConstructorUsedError;
  @JsonKey(name: 'STATUS')
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'PARAM_PF')
  String get paramPf => throw _privateConstructorUsedError;
  @JsonKey(name: 'PARAM_EPI')
  String get paramEpi => throw _privateConstructorUsedError;
  @JsonKey(name: 'PARAM_EPE')
  String get paramEpe => throw _privateConstructorUsedError;
  @JsonKey(name: 'PARAM_EQL')
  String get paramEql => throw _privateConstructorUsedError;
  @JsonKey(name: 'PARAM_EQC')
  String get paramEqc => throw _privateConstructorUsedError;
  @JsonKey(name: 'PARAM_UA')
  String get paramUa => throw _privateConstructorUsedError;
  @JsonKey(name: 'PARAM_UB')
  String get paramUb => throw _privateConstructorUsedError;
  @JsonKey(name: 'PARAM_UC')
  String get paramUc => throw _privateConstructorUsedError;
  @JsonKey(name: 'PARAM_IA')
  String get paramIa => throw _privateConstructorUsedError;
  @JsonKey(name: 'PARAM_IB')
  String get paramIb => throw _privateConstructorUsedError;
  @JsonKey(name: 'PARAM_IC')
  String get paramIc => throw _privateConstructorUsedError;
  @JsonKey(name: 'PARAM_PA')
  String get paramPa => throw _privateConstructorUsedError;
  @JsonKey(name: 'PARAM_PB')
  String get paramPb => throw _privateConstructorUsedError;
  @JsonKey(name: 'PARAM_PC')
  String get paramPc => throw _privateConstructorUsedError;
  @JsonKey(name: 'PARAM_P')
  String get paramP => throw _privateConstructorUsedError;
  @JsonKey(name: 'PARAM_QA')
  String get paramQa => throw _privateConstructorUsedError;
  @JsonKey(name: 'PARAM_QB')
  String get paramQb => throw _privateConstructorUsedError;
  @JsonKey(name: 'PARAM_QC')
  String get paramQc => throw _privateConstructorUsedError;
  @JsonKey(name: 'PARAM_Q')
  String get paramQ => throw _privateConstructorUsedError;
  @JsonKey(name: 'THD')
  String get thd => throw _privateConstructorUsedError;
  @JsonKey(name: 'CT')
  String get ct => throw _privateConstructorUsedError;
  @JsonKey(name: 'THD_UA')
  String get thdUa => throw _privateConstructorUsedError;
  @JsonKey(name: 'THD_UB')
  String get thdUb => throw _privateConstructorUsedError;
  @JsonKey(name: 'THD_UC')
  String get thdUc => throw _privateConstructorUsedError;
  @JsonKey(name: 'THD_IA')
  String get thdIa => throw _privateConstructorUsedError;
  @JsonKey(name: 'THD_IB')
  String get thdIb => throw _privateConstructorUsedError;
  @JsonKey(name: 'THD_IC')
  String get thdIc => throw _privateConstructorUsedError;

  /// Serializes this LastedLogDataResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LastedLogDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LastedLogDataResponseCopyWith<LastedLogDataResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LastedLogDataResponseCopyWith<$Res> {
  factory $LastedLogDataResponseCopyWith(LastedLogDataResponse value,
          $Res Function(LastedLogDataResponse) then) =
      _$LastedLogDataResponseCopyWithImpl<$Res, LastedLogDataResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'ID') int id,
      @JsonKey(name: 'UPDATE_TIME') DateTime? updateTime,
      @JsonKey(name: 'METER_NAME') String meterName,
      @JsonKey(name: 'STATUS') int status,
      @JsonKey(name: 'PARAM_PF') String paramPf,
      @JsonKey(name: 'PARAM_EPI') String paramEpi,
      @JsonKey(name: 'PARAM_EPE') String paramEpe,
      @JsonKey(name: 'PARAM_EQL') String paramEql,
      @JsonKey(name: 'PARAM_EQC') String paramEqc,
      @JsonKey(name: 'PARAM_UA') String paramUa,
      @JsonKey(name: 'PARAM_UB') String paramUb,
      @JsonKey(name: 'PARAM_UC') String paramUc,
      @JsonKey(name: 'PARAM_IA') String paramIa,
      @JsonKey(name: 'PARAM_IB') String paramIb,
      @JsonKey(name: 'PARAM_IC') String paramIc,
      @JsonKey(name: 'PARAM_PA') String paramPa,
      @JsonKey(name: 'PARAM_PB') String paramPb,
      @JsonKey(name: 'PARAM_PC') String paramPc,
      @JsonKey(name: 'PARAM_P') String paramP,
      @JsonKey(name: 'PARAM_QA') String paramQa,
      @JsonKey(name: 'PARAM_QB') String paramQb,
      @JsonKey(name: 'PARAM_QC') String paramQc,
      @JsonKey(name: 'PARAM_Q') String paramQ,
      @JsonKey(name: 'THD') String thd,
      @JsonKey(name: 'CT') String ct,
      @JsonKey(name: 'THD_UA') String thdUa,
      @JsonKey(name: 'THD_UB') String thdUb,
      @JsonKey(name: 'THD_UC') String thdUc,
      @JsonKey(name: 'THD_IA') String thdIa,
      @JsonKey(name: 'THD_IB') String thdIb,
      @JsonKey(name: 'THD_IC') String thdIc});
}

/// @nodoc
class _$LastedLogDataResponseCopyWithImpl<$Res,
        $Val extends LastedLogDataResponse>
    implements $LastedLogDataResponseCopyWith<$Res> {
  _$LastedLogDataResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LastedLogDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? updateTime = freezed,
    Object? meterName = null,
    Object? status = null,
    Object? paramPf = null,
    Object? paramEpi = null,
    Object? paramEpe = null,
    Object? paramEql = null,
    Object? paramEqc = null,
    Object? paramUa = null,
    Object? paramUb = null,
    Object? paramUc = null,
    Object? paramIa = null,
    Object? paramIb = null,
    Object? paramIc = null,
    Object? paramPa = null,
    Object? paramPb = null,
    Object? paramPc = null,
    Object? paramP = null,
    Object? paramQa = null,
    Object? paramQb = null,
    Object? paramQc = null,
    Object? paramQ = null,
    Object? thd = null,
    Object? ct = null,
    Object? thdUa = null,
    Object? thdUb = null,
    Object? thdUc = null,
    Object? thdIa = null,
    Object? thdIb = null,
    Object? thdIc = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      updateTime: freezed == updateTime
          ? _value.updateTime
          : updateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      meterName: null == meterName
          ? _value.meterName
          : meterName // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      paramPf: null == paramPf
          ? _value.paramPf
          : paramPf // ignore: cast_nullable_to_non_nullable
              as String,
      paramEpi: null == paramEpi
          ? _value.paramEpi
          : paramEpi // ignore: cast_nullable_to_non_nullable
              as String,
      paramEpe: null == paramEpe
          ? _value.paramEpe
          : paramEpe // ignore: cast_nullable_to_non_nullable
              as String,
      paramEql: null == paramEql
          ? _value.paramEql
          : paramEql // ignore: cast_nullable_to_non_nullable
              as String,
      paramEqc: null == paramEqc
          ? _value.paramEqc
          : paramEqc // ignore: cast_nullable_to_non_nullable
              as String,
      paramUa: null == paramUa
          ? _value.paramUa
          : paramUa // ignore: cast_nullable_to_non_nullable
              as String,
      paramUb: null == paramUb
          ? _value.paramUb
          : paramUb // ignore: cast_nullable_to_non_nullable
              as String,
      paramUc: null == paramUc
          ? _value.paramUc
          : paramUc // ignore: cast_nullable_to_non_nullable
              as String,
      paramIa: null == paramIa
          ? _value.paramIa
          : paramIa // ignore: cast_nullable_to_non_nullable
              as String,
      paramIb: null == paramIb
          ? _value.paramIb
          : paramIb // ignore: cast_nullable_to_non_nullable
              as String,
      paramIc: null == paramIc
          ? _value.paramIc
          : paramIc // ignore: cast_nullable_to_non_nullable
              as String,
      paramPa: null == paramPa
          ? _value.paramPa
          : paramPa // ignore: cast_nullable_to_non_nullable
              as String,
      paramPb: null == paramPb
          ? _value.paramPb
          : paramPb // ignore: cast_nullable_to_non_nullable
              as String,
      paramPc: null == paramPc
          ? _value.paramPc
          : paramPc // ignore: cast_nullable_to_non_nullable
              as String,
      paramP: null == paramP
          ? _value.paramP
          : paramP // ignore: cast_nullable_to_non_nullable
              as String,
      paramQa: null == paramQa
          ? _value.paramQa
          : paramQa // ignore: cast_nullable_to_non_nullable
              as String,
      paramQb: null == paramQb
          ? _value.paramQb
          : paramQb // ignore: cast_nullable_to_non_nullable
              as String,
      paramQc: null == paramQc
          ? _value.paramQc
          : paramQc // ignore: cast_nullable_to_non_nullable
              as String,
      paramQ: null == paramQ
          ? _value.paramQ
          : paramQ // ignore: cast_nullable_to_non_nullable
              as String,
      thd: null == thd
          ? _value.thd
          : thd // ignore: cast_nullable_to_non_nullable
              as String,
      ct: null == ct
          ? _value.ct
          : ct // ignore: cast_nullable_to_non_nullable
              as String,
      thdUa: null == thdUa
          ? _value.thdUa
          : thdUa // ignore: cast_nullable_to_non_nullable
              as String,
      thdUb: null == thdUb
          ? _value.thdUb
          : thdUb // ignore: cast_nullable_to_non_nullable
              as String,
      thdUc: null == thdUc
          ? _value.thdUc
          : thdUc // ignore: cast_nullable_to_non_nullable
              as String,
      thdIa: null == thdIa
          ? _value.thdIa
          : thdIa // ignore: cast_nullable_to_non_nullable
              as String,
      thdIb: null == thdIb
          ? _value.thdIb
          : thdIb // ignore: cast_nullable_to_non_nullable
              as String,
      thdIc: null == thdIc
          ? _value.thdIc
          : thdIc // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LastedLogDataResponseImplCopyWith<$Res>
    implements $LastedLogDataResponseCopyWith<$Res> {
  factory _$$LastedLogDataResponseImplCopyWith(
          _$LastedLogDataResponseImpl value,
          $Res Function(_$LastedLogDataResponseImpl) then) =
      __$$LastedLogDataResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'ID') int id,
      @JsonKey(name: 'UPDATE_TIME') DateTime? updateTime,
      @JsonKey(name: 'METER_NAME') String meterName,
      @JsonKey(name: 'STATUS') int status,
      @JsonKey(name: 'PARAM_PF') String paramPf,
      @JsonKey(name: 'PARAM_EPI') String paramEpi,
      @JsonKey(name: 'PARAM_EPE') String paramEpe,
      @JsonKey(name: 'PARAM_EQL') String paramEql,
      @JsonKey(name: 'PARAM_EQC') String paramEqc,
      @JsonKey(name: 'PARAM_UA') String paramUa,
      @JsonKey(name: 'PARAM_UB') String paramUb,
      @JsonKey(name: 'PARAM_UC') String paramUc,
      @JsonKey(name: 'PARAM_IA') String paramIa,
      @JsonKey(name: 'PARAM_IB') String paramIb,
      @JsonKey(name: 'PARAM_IC') String paramIc,
      @JsonKey(name: 'PARAM_PA') String paramPa,
      @JsonKey(name: 'PARAM_PB') String paramPb,
      @JsonKey(name: 'PARAM_PC') String paramPc,
      @JsonKey(name: 'PARAM_P') String paramP,
      @JsonKey(name: 'PARAM_QA') String paramQa,
      @JsonKey(name: 'PARAM_QB') String paramQb,
      @JsonKey(name: 'PARAM_QC') String paramQc,
      @JsonKey(name: 'PARAM_Q') String paramQ,
      @JsonKey(name: 'THD') String thd,
      @JsonKey(name: 'CT') String ct,
      @JsonKey(name: 'THD_UA') String thdUa,
      @JsonKey(name: 'THD_UB') String thdUb,
      @JsonKey(name: 'THD_UC') String thdUc,
      @JsonKey(name: 'THD_IA') String thdIa,
      @JsonKey(name: 'THD_IB') String thdIb,
      @JsonKey(name: 'THD_IC') String thdIc});
}

/// @nodoc
class __$$LastedLogDataResponseImplCopyWithImpl<$Res>
    extends _$LastedLogDataResponseCopyWithImpl<$Res,
        _$LastedLogDataResponseImpl>
    implements _$$LastedLogDataResponseImplCopyWith<$Res> {
  __$$LastedLogDataResponseImplCopyWithImpl(_$LastedLogDataResponseImpl _value,
      $Res Function(_$LastedLogDataResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of LastedLogDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? updateTime = freezed,
    Object? meterName = null,
    Object? status = null,
    Object? paramPf = null,
    Object? paramEpi = null,
    Object? paramEpe = null,
    Object? paramEql = null,
    Object? paramEqc = null,
    Object? paramUa = null,
    Object? paramUb = null,
    Object? paramUc = null,
    Object? paramIa = null,
    Object? paramIb = null,
    Object? paramIc = null,
    Object? paramPa = null,
    Object? paramPb = null,
    Object? paramPc = null,
    Object? paramP = null,
    Object? paramQa = null,
    Object? paramQb = null,
    Object? paramQc = null,
    Object? paramQ = null,
    Object? thd = null,
    Object? ct = null,
    Object? thdUa = null,
    Object? thdUb = null,
    Object? thdUc = null,
    Object? thdIa = null,
    Object? thdIb = null,
    Object? thdIc = null,
  }) {
    return _then(_$LastedLogDataResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      updateTime: freezed == updateTime
          ? _value.updateTime
          : updateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      meterName: null == meterName
          ? _value.meterName
          : meterName // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      paramPf: null == paramPf
          ? _value.paramPf
          : paramPf // ignore: cast_nullable_to_non_nullable
              as String,
      paramEpi: null == paramEpi
          ? _value.paramEpi
          : paramEpi // ignore: cast_nullable_to_non_nullable
              as String,
      paramEpe: null == paramEpe
          ? _value.paramEpe
          : paramEpe // ignore: cast_nullable_to_non_nullable
              as String,
      paramEql: null == paramEql
          ? _value.paramEql
          : paramEql // ignore: cast_nullable_to_non_nullable
              as String,
      paramEqc: null == paramEqc
          ? _value.paramEqc
          : paramEqc // ignore: cast_nullable_to_non_nullable
              as String,
      paramUa: null == paramUa
          ? _value.paramUa
          : paramUa // ignore: cast_nullable_to_non_nullable
              as String,
      paramUb: null == paramUb
          ? _value.paramUb
          : paramUb // ignore: cast_nullable_to_non_nullable
              as String,
      paramUc: null == paramUc
          ? _value.paramUc
          : paramUc // ignore: cast_nullable_to_non_nullable
              as String,
      paramIa: null == paramIa
          ? _value.paramIa
          : paramIa // ignore: cast_nullable_to_non_nullable
              as String,
      paramIb: null == paramIb
          ? _value.paramIb
          : paramIb // ignore: cast_nullable_to_non_nullable
              as String,
      paramIc: null == paramIc
          ? _value.paramIc
          : paramIc // ignore: cast_nullable_to_non_nullable
              as String,
      paramPa: null == paramPa
          ? _value.paramPa
          : paramPa // ignore: cast_nullable_to_non_nullable
              as String,
      paramPb: null == paramPb
          ? _value.paramPb
          : paramPb // ignore: cast_nullable_to_non_nullable
              as String,
      paramPc: null == paramPc
          ? _value.paramPc
          : paramPc // ignore: cast_nullable_to_non_nullable
              as String,
      paramP: null == paramP
          ? _value.paramP
          : paramP // ignore: cast_nullable_to_non_nullable
              as String,
      paramQa: null == paramQa
          ? _value.paramQa
          : paramQa // ignore: cast_nullable_to_non_nullable
              as String,
      paramQb: null == paramQb
          ? _value.paramQb
          : paramQb // ignore: cast_nullable_to_non_nullable
              as String,
      paramQc: null == paramQc
          ? _value.paramQc
          : paramQc // ignore: cast_nullable_to_non_nullable
              as String,
      paramQ: null == paramQ
          ? _value.paramQ
          : paramQ // ignore: cast_nullable_to_non_nullable
              as String,
      thd: null == thd
          ? _value.thd
          : thd // ignore: cast_nullable_to_non_nullable
              as String,
      ct: null == ct
          ? _value.ct
          : ct // ignore: cast_nullable_to_non_nullable
              as String,
      thdUa: null == thdUa
          ? _value.thdUa
          : thdUa // ignore: cast_nullable_to_non_nullable
              as String,
      thdUb: null == thdUb
          ? _value.thdUb
          : thdUb // ignore: cast_nullable_to_non_nullable
              as String,
      thdUc: null == thdUc
          ? _value.thdUc
          : thdUc // ignore: cast_nullable_to_non_nullable
              as String,
      thdIa: null == thdIa
          ? _value.thdIa
          : thdIa // ignore: cast_nullable_to_non_nullable
              as String,
      thdIb: null == thdIb
          ? _value.thdIb
          : thdIb // ignore: cast_nullable_to_non_nullable
              as String,
      thdIc: null == thdIc
          ? _value.thdIc
          : thdIc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LastedLogDataResponseImpl implements _LastedLogDataResponse {
  const _$LastedLogDataResponseImpl(
      {@JsonKey(name: 'ID') this.id = 0,
      @JsonKey(name: 'UPDATE_TIME') this.updateTime,
      @JsonKey(name: 'METER_NAME') this.meterName = '',
      @JsonKey(name: 'STATUS') this.status = 0,
      @JsonKey(name: 'PARAM_PF') this.paramPf = '',
      @JsonKey(name: 'PARAM_EPI') this.paramEpi = '',
      @JsonKey(name: 'PARAM_EPE') this.paramEpe = '',
      @JsonKey(name: 'PARAM_EQL') this.paramEql = '',
      @JsonKey(name: 'PARAM_EQC') this.paramEqc = '',
      @JsonKey(name: 'PARAM_UA') this.paramUa = '',
      @JsonKey(name: 'PARAM_UB') this.paramUb = '',
      @JsonKey(name: 'PARAM_UC') this.paramUc = '',
      @JsonKey(name: 'PARAM_IA') this.paramIa = '',
      @JsonKey(name: 'PARAM_IB') this.paramIb = '',
      @JsonKey(name: 'PARAM_IC') this.paramIc = '',
      @JsonKey(name: 'PARAM_PA') this.paramPa = '',
      @JsonKey(name: 'PARAM_PB') this.paramPb = '',
      @JsonKey(name: 'PARAM_PC') this.paramPc = '',
      @JsonKey(name: 'PARAM_P') this.paramP = '',
      @JsonKey(name: 'PARAM_QA') this.paramQa = '',
      @JsonKey(name: 'PARAM_QB') this.paramQb = '',
      @JsonKey(name: 'PARAM_QC') this.paramQc = '',
      @JsonKey(name: 'PARAM_Q') this.paramQ = '',
      @JsonKey(name: 'THD') this.thd = '',
      @JsonKey(name: 'CT') this.ct = '',
      @JsonKey(name: 'THD_UA') this.thdUa = '',
      @JsonKey(name: 'THD_UB') this.thdUb = '',
      @JsonKey(name: 'THD_UC') this.thdUc = '',
      @JsonKey(name: 'THD_IA') this.thdIa = '',
      @JsonKey(name: 'THD_IB') this.thdIb = '',
      @JsonKey(name: 'THD_IC') this.thdIc = ''});

  factory _$LastedLogDataResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$LastedLogDataResponseImplFromJson(json);

  @override
  @JsonKey(name: 'ID')
  final int id;
// @JsonKey(name: 'GATEWAY_ID') @Default(0) double gatewayId,
// @JsonKey(name: 'METER_CODE') @Default(0) double meterCode,
  @override
  @JsonKey(name: 'UPDATE_TIME')
  final DateTime? updateTime;
  @override
  @JsonKey(name: 'METER_NAME')
  final String meterName;
  @override
  @JsonKey(name: 'STATUS')
  final int status;
  @override
  @JsonKey(name: 'PARAM_PF')
  final String paramPf;
  @override
  @JsonKey(name: 'PARAM_EPI')
  final String paramEpi;
  @override
  @JsonKey(name: 'PARAM_EPE')
  final String paramEpe;
  @override
  @JsonKey(name: 'PARAM_EQL')
  final String paramEql;
  @override
  @JsonKey(name: 'PARAM_EQC')
  final String paramEqc;
  @override
  @JsonKey(name: 'PARAM_UA')
  final String paramUa;
  @override
  @JsonKey(name: 'PARAM_UB')
  final String paramUb;
  @override
  @JsonKey(name: 'PARAM_UC')
  final String paramUc;
  @override
  @JsonKey(name: 'PARAM_IA')
  final String paramIa;
  @override
  @JsonKey(name: 'PARAM_IB')
  final String paramIb;
  @override
  @JsonKey(name: 'PARAM_IC')
  final String paramIc;
  @override
  @JsonKey(name: 'PARAM_PA')
  final String paramPa;
  @override
  @JsonKey(name: 'PARAM_PB')
  final String paramPb;
  @override
  @JsonKey(name: 'PARAM_PC')
  final String paramPc;
  @override
  @JsonKey(name: 'PARAM_P')
  final String paramP;
  @override
  @JsonKey(name: 'PARAM_QA')
  final String paramQa;
  @override
  @JsonKey(name: 'PARAM_QB')
  final String paramQb;
  @override
  @JsonKey(name: 'PARAM_QC')
  final String paramQc;
  @override
  @JsonKey(name: 'PARAM_Q')
  final String paramQ;
  @override
  @JsonKey(name: 'THD')
  final String thd;
  @override
  @JsonKey(name: 'CT')
  final String ct;
  @override
  @JsonKey(name: 'THD_UA')
  final String thdUa;
  @override
  @JsonKey(name: 'THD_UB')
  final String thdUb;
  @override
  @JsonKey(name: 'THD_UC')
  final String thdUc;
  @override
  @JsonKey(name: 'THD_IA')
  final String thdIa;
  @override
  @JsonKey(name: 'THD_IB')
  final String thdIb;
  @override
  @JsonKey(name: 'THD_IC')
  final String thdIc;

  @override
  String toString() {
    return 'LastedLogDataResponse(id: $id, updateTime: $updateTime, meterName: $meterName, status: $status, paramPf: $paramPf, paramEpi: $paramEpi, paramEpe: $paramEpe, paramEql: $paramEql, paramEqc: $paramEqc, paramUa: $paramUa, paramUb: $paramUb, paramUc: $paramUc, paramIa: $paramIa, paramIb: $paramIb, paramIc: $paramIc, paramPa: $paramPa, paramPb: $paramPb, paramPc: $paramPc, paramP: $paramP, paramQa: $paramQa, paramQb: $paramQb, paramQc: $paramQc, paramQ: $paramQ, thd: $thd, ct: $ct, thdUa: $thdUa, thdUb: $thdUb, thdUc: $thdUc, thdIa: $thdIa, thdIb: $thdIb, thdIc: $thdIc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LastedLogDataResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.updateTime, updateTime) ||
                other.updateTime == updateTime) &&
            (identical(other.meterName, meterName) ||
                other.meterName == meterName) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.paramPf, paramPf) || other.paramPf == paramPf) &&
            (identical(other.paramEpi, paramEpi) ||
                other.paramEpi == paramEpi) &&
            (identical(other.paramEpe, paramEpe) ||
                other.paramEpe == paramEpe) &&
            (identical(other.paramEql, paramEql) ||
                other.paramEql == paramEql) &&
            (identical(other.paramEqc, paramEqc) ||
                other.paramEqc == paramEqc) &&
            (identical(other.paramUa, paramUa) || other.paramUa == paramUa) &&
            (identical(other.paramUb, paramUb) || other.paramUb == paramUb) &&
            (identical(other.paramUc, paramUc) || other.paramUc == paramUc) &&
            (identical(other.paramIa, paramIa) || other.paramIa == paramIa) &&
            (identical(other.paramIb, paramIb) || other.paramIb == paramIb) &&
            (identical(other.paramIc, paramIc) || other.paramIc == paramIc) &&
            (identical(other.paramPa, paramPa) || other.paramPa == paramPa) &&
            (identical(other.paramPb, paramPb) || other.paramPb == paramPb) &&
            (identical(other.paramPc, paramPc) || other.paramPc == paramPc) &&
            (identical(other.paramP, paramP) || other.paramP == paramP) &&
            (identical(other.paramQa, paramQa) || other.paramQa == paramQa) &&
            (identical(other.paramQb, paramQb) || other.paramQb == paramQb) &&
            (identical(other.paramQc, paramQc) || other.paramQc == paramQc) &&
            (identical(other.paramQ, paramQ) || other.paramQ == paramQ) &&
            (identical(other.thd, thd) || other.thd == thd) &&
            (identical(other.ct, ct) || other.ct == ct) &&
            (identical(other.thdUa, thdUa) || other.thdUa == thdUa) &&
            (identical(other.thdUb, thdUb) || other.thdUb == thdUb) &&
            (identical(other.thdUc, thdUc) || other.thdUc == thdUc) &&
            (identical(other.thdIa, thdIa) || other.thdIa == thdIa) &&
            (identical(other.thdIb, thdIb) || other.thdIb == thdIb) &&
            (identical(other.thdIc, thdIc) || other.thdIc == thdIc));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        updateTime,
        meterName,
        status,
        paramPf,
        paramEpi,
        paramEpe,
        paramEql,
        paramEqc,
        paramUa,
        paramUb,
        paramUc,
        paramIa,
        paramIb,
        paramIc,
        paramPa,
        paramPb,
        paramPc,
        paramP,
        paramQa,
        paramQb,
        paramQc,
        paramQ,
        thd,
        ct,
        thdUa,
        thdUb,
        thdUc,
        thdIa,
        thdIb,
        thdIc
      ]);

  /// Create a copy of LastedLogDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LastedLogDataResponseImplCopyWith<_$LastedLogDataResponseImpl>
      get copyWith => __$$LastedLogDataResponseImplCopyWithImpl<
          _$LastedLogDataResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LastedLogDataResponseImplToJson(
      this,
    );
  }
}

abstract class _LastedLogDataResponse implements LastedLogDataResponse {
  const factory _LastedLogDataResponse(
          {@JsonKey(name: 'ID') final int id,
          @JsonKey(name: 'UPDATE_TIME') final DateTime? updateTime,
          @JsonKey(name: 'METER_NAME') final String meterName,
          @JsonKey(name: 'STATUS') final int status,
          @JsonKey(name: 'PARAM_PF') final String paramPf,
          @JsonKey(name: 'PARAM_EPI') final String paramEpi,
          @JsonKey(name: 'PARAM_EPE') final String paramEpe,
          @JsonKey(name: 'PARAM_EQL') final String paramEql,
          @JsonKey(name: 'PARAM_EQC') final String paramEqc,
          @JsonKey(name: 'PARAM_UA') final String paramUa,
          @JsonKey(name: 'PARAM_UB') final String paramUb,
          @JsonKey(name: 'PARAM_UC') final String paramUc,
          @JsonKey(name: 'PARAM_IA') final String paramIa,
          @JsonKey(name: 'PARAM_IB') final String paramIb,
          @JsonKey(name: 'PARAM_IC') final String paramIc,
          @JsonKey(name: 'PARAM_PA') final String paramPa,
          @JsonKey(name: 'PARAM_PB') final String paramPb,
          @JsonKey(name: 'PARAM_PC') final String paramPc,
          @JsonKey(name: 'PARAM_P') final String paramP,
          @JsonKey(name: 'PARAM_QA') final String paramQa,
          @JsonKey(name: 'PARAM_QB') final String paramQb,
          @JsonKey(name: 'PARAM_QC') final String paramQc,
          @JsonKey(name: 'PARAM_Q') final String paramQ,
          @JsonKey(name: 'THD') final String thd,
          @JsonKey(name: 'CT') final String ct,
          @JsonKey(name: 'THD_UA') final String thdUa,
          @JsonKey(name: 'THD_UB') final String thdUb,
          @JsonKey(name: 'THD_UC') final String thdUc,
          @JsonKey(name: 'THD_IA') final String thdIa,
          @JsonKey(name: 'THD_IB') final String thdIb,
          @JsonKey(name: 'THD_IC') final String thdIc}) =
      _$LastedLogDataResponseImpl;

  factory _LastedLogDataResponse.fromJson(Map<String, dynamic> json) =
      _$LastedLogDataResponseImpl.fromJson;

  @override
  @JsonKey(name: 'ID')
  int get id; // @JsonKey(name: 'GATEWAY_ID') @Default(0) double gatewayId,
// @JsonKey(name: 'METER_CODE') @Default(0) double meterCode,
  @override
  @JsonKey(name: 'UPDATE_TIME')
  DateTime? get updateTime;
  @override
  @JsonKey(name: 'METER_NAME')
  String get meterName;
  @override
  @JsonKey(name: 'STATUS')
  int get status;
  @override
  @JsonKey(name: 'PARAM_PF')
  String get paramPf;
  @override
  @JsonKey(name: 'PARAM_EPI')
  String get paramEpi;
  @override
  @JsonKey(name: 'PARAM_EPE')
  String get paramEpe;
  @override
  @JsonKey(name: 'PARAM_EQL')
  String get paramEql;
  @override
  @JsonKey(name: 'PARAM_EQC')
  String get paramEqc;
  @override
  @JsonKey(name: 'PARAM_UA')
  String get paramUa;
  @override
  @JsonKey(name: 'PARAM_UB')
  String get paramUb;
  @override
  @JsonKey(name: 'PARAM_UC')
  String get paramUc;
  @override
  @JsonKey(name: 'PARAM_IA')
  String get paramIa;
  @override
  @JsonKey(name: 'PARAM_IB')
  String get paramIb;
  @override
  @JsonKey(name: 'PARAM_IC')
  String get paramIc;
  @override
  @JsonKey(name: 'PARAM_PA')
  String get paramPa;
  @override
  @JsonKey(name: 'PARAM_PB')
  String get paramPb;
  @override
  @JsonKey(name: 'PARAM_PC')
  String get paramPc;
  @override
  @JsonKey(name: 'PARAM_P')
  String get paramP;
  @override
  @JsonKey(name: 'PARAM_QA')
  String get paramQa;
  @override
  @JsonKey(name: 'PARAM_QB')
  String get paramQb;
  @override
  @JsonKey(name: 'PARAM_QC')
  String get paramQc;
  @override
  @JsonKey(name: 'PARAM_Q')
  String get paramQ;
  @override
  @JsonKey(name: 'THD')
  String get thd;
  @override
  @JsonKey(name: 'CT')
  String get ct;
  @override
  @JsonKey(name: 'THD_UA')
  String get thdUa;
  @override
  @JsonKey(name: 'THD_UB')
  String get thdUb;
  @override
  @JsonKey(name: 'THD_UC')
  String get thdUc;
  @override
  @JsonKey(name: 'THD_IA')
  String get thdIa;
  @override
  @JsonKey(name: 'THD_IB')
  String get thdIb;
  @override
  @JsonKey(name: 'THD_IC')
  String get thdIc;

  /// Create a copy of LastedLogDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LastedLogDataResponseImplCopyWith<_$LastedLogDataResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
