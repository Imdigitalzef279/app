// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'breaker_state_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BreakerStateResponse _$BreakerStateResponseFromJson(Map<String, dynamic> json) {
  return _BreakerStateResponse.fromJson(json);
}

/// @nodoc
mixin _$BreakerStateResponse {
  @JsonKey(name: 'gatewaySn')
  String get gatewaySn => throw _privateConstructorUsedError;
  @JsonKey(name: 'breakerSn')
  String get breakerSn => throw _privateConstructorUsedError;
  @JsonKey(name: 'addr')
  String get addr => throw _privateConstructorUsedError;
  @JsonKey(name: 'state')
  String get state => throw _privateConstructorUsedError;
  @JsonKey(name: 'rlySta')
  int get rlySta => throw _privateConstructorUsedError;
  @JsonKey(name: 'rlyRepSta')
  int get rlyRepSta => throw _privateConstructorUsedError;
  @JsonKey(name: 'lockSta')
  int get lockSta => throw _privateConstructorUsedError;
  @JsonKey(name: 'updatedAt')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this BreakerStateResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BreakerStateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BreakerStateResponseCopyWith<BreakerStateResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BreakerStateResponseCopyWith<$Res> {
  factory $BreakerStateResponseCopyWith(BreakerStateResponse value,
          $Res Function(BreakerStateResponse) then) =
      _$BreakerStateResponseCopyWithImpl<$Res, BreakerStateResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'gatewaySn') String gatewaySn,
      @JsonKey(name: 'breakerSn') String breakerSn,
      @JsonKey(name: 'addr') String addr,
      @JsonKey(name: 'state') String state,
      @JsonKey(name: 'rlySta') int rlySta,
      @JsonKey(name: 'rlyRepSta') int rlyRepSta,
      @JsonKey(name: 'lockSta') int lockSta,
      @JsonKey(name: 'updatedAt') DateTime? updatedAt});
}

/// @nodoc
class _$BreakerStateResponseCopyWithImpl<$Res,
        $Val extends BreakerStateResponse>
    implements $BreakerStateResponseCopyWith<$Res> {
  _$BreakerStateResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BreakerStateResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gatewaySn = null,
    Object? breakerSn = null,
    Object? addr = null,
    Object? state = null,
    Object? rlySta = null,
    Object? rlyRepSta = null,
    Object? lockSta = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      gatewaySn: null == gatewaySn
          ? _value.gatewaySn
          : gatewaySn // ignore: cast_nullable_to_non_nullable
              as String,
      breakerSn: null == breakerSn
          ? _value.breakerSn
          : breakerSn // ignore: cast_nullable_to_non_nullable
              as String,
      addr: null == addr
          ? _value.addr
          : addr // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      rlySta: null == rlySta
          ? _value.rlySta
          : rlySta // ignore: cast_nullable_to_non_nullable
              as int,
      rlyRepSta: null == rlyRepSta
          ? _value.rlyRepSta
          : rlyRepSta // ignore: cast_nullable_to_non_nullable
              as int,
      lockSta: null == lockSta
          ? _value.lockSta
          : lockSta // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BreakerStateResponseImplCopyWith<$Res>
    implements $BreakerStateResponseCopyWith<$Res> {
  factory _$$BreakerStateResponseImplCopyWith(_$BreakerStateResponseImpl value,
          $Res Function(_$BreakerStateResponseImpl) then) =
      __$$BreakerStateResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'gatewaySn') String gatewaySn,
      @JsonKey(name: 'breakerSn') String breakerSn,
      @JsonKey(name: 'addr') String addr,
      @JsonKey(name: 'state') String state,
      @JsonKey(name: 'rlySta') int rlySta,
      @JsonKey(name: 'rlyRepSta') int rlyRepSta,
      @JsonKey(name: 'lockSta') int lockSta,
      @JsonKey(name: 'updatedAt') DateTime? updatedAt});
}

/// @nodoc
class __$$BreakerStateResponseImplCopyWithImpl<$Res>
    extends _$BreakerStateResponseCopyWithImpl<$Res, _$BreakerStateResponseImpl>
    implements _$$BreakerStateResponseImplCopyWith<$Res> {
  __$$BreakerStateResponseImplCopyWithImpl(_$BreakerStateResponseImpl _value,
      $Res Function(_$BreakerStateResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of BreakerStateResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gatewaySn = null,
    Object? breakerSn = null,
    Object? addr = null,
    Object? state = null,
    Object? rlySta = null,
    Object? rlyRepSta = null,
    Object? lockSta = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$BreakerStateResponseImpl(
      gatewaySn: null == gatewaySn
          ? _value.gatewaySn
          : gatewaySn // ignore: cast_nullable_to_non_nullable
              as String,
      breakerSn: null == breakerSn
          ? _value.breakerSn
          : breakerSn // ignore: cast_nullable_to_non_nullable
              as String,
      addr: null == addr
          ? _value.addr
          : addr // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      rlySta: null == rlySta
          ? _value.rlySta
          : rlySta // ignore: cast_nullable_to_non_nullable
              as int,
      rlyRepSta: null == rlyRepSta
          ? _value.rlyRepSta
          : rlyRepSta // ignore: cast_nullable_to_non_nullable
              as int,
      lockSta: null == lockSta
          ? _value.lockSta
          : lockSta // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BreakerStateResponseImpl implements _BreakerStateResponse {
  const _$BreakerStateResponseImpl(
      {@JsonKey(name: 'gatewaySn') this.gatewaySn = '',
      @JsonKey(name: 'breakerSn') this.breakerSn = '',
      @JsonKey(name: 'addr') this.addr = '',
      @JsonKey(name: 'state') this.state = '',
      @JsonKey(name: 'rlySta') this.rlySta = 0,
      @JsonKey(name: 'rlyRepSta') this.rlyRepSta = 0,
      @JsonKey(name: 'lockSta') this.lockSta = 0,
      @JsonKey(name: 'updatedAt') this.updatedAt});

  factory _$BreakerStateResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$BreakerStateResponseImplFromJson(json);

  @override
  @JsonKey(name: 'gatewaySn')
  final String gatewaySn;
  @override
  @JsonKey(name: 'breakerSn')
  final String breakerSn;
  @override
  @JsonKey(name: 'addr')
  final String addr;
  @override
  @JsonKey(name: 'state')
  final String state;
  @override
  @JsonKey(name: 'rlySta')
  final
  int rlySta;
  @override
  @JsonKey(name: 'rlyRepSta')
  final int rlyRepSta;
  @override
  @JsonKey(name: 'lockSta')
  final int lockSta;
  @override
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'BreakerStateResponse(gatewaySn: $gatewaySn, breakerSn: $breakerSn, addr: $addr, state: $state, rlySta: $rlySta, rlyRepSta: $rlyRepSta, lockSta: $lockSta, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BreakerStateResponseImpl &&
            (identical(other.gatewaySn, gatewaySn) ||
                other.gatewaySn == gatewaySn) &&
            (identical(other.breakerSn, breakerSn) ||
                other.breakerSn == breakerSn) &&
            (identical(other.addr, addr) || other.addr == addr) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.rlySta, rlySta) || other.rlySta == rlySta) &&
            (identical(other.rlyRepSta, rlyRepSta) ||
                other.rlyRepSta == rlyRepSta) &&
            (identical(other.lockSta, lockSta) || other.lockSta == lockSta) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, gatewaySn, breakerSn, addr,
      state, rlySta, rlyRepSta, lockSta, updatedAt);

  /// Create a copy of BreakerStateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BreakerStateResponseImplCopyWith<_$BreakerStateResponseImpl>
      get copyWith =>
          __$$BreakerStateResponseImplCopyWithImpl<_$BreakerStateResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BreakerStateResponseImplToJson(
      this,
    );
  }
}

abstract class _BreakerStateResponse implements BreakerStateResponse {
  const factory _BreakerStateResponse(
          {@JsonKey(name: 'gatewaySn') final String gatewaySn,
          @JsonKey(name: 'breakerSn') final String breakerSn,
          @JsonKey(name: 'addr') final String addr,
          @JsonKey(name: 'state') final String state,
          @JsonKey(name: 'rlySta') final int rlySta,
          @JsonKey(name: 'rlyRepSta') final int rlyRepSta,
          @JsonKey(name: 'lockSta') final int lockSta,
          @JsonKey(name: 'updatedAt') final DateTime? updatedAt}) =
      _$BreakerStateResponseImpl;

  factory _BreakerStateResponse.fromJson(Map<String, dynamic> json) =
      _$BreakerStateResponseImpl.fromJson;

  @override
  @JsonKey(name: 'gatewaySn')
  String get gatewaySn;
  @override
  @JsonKey(name: 'breakerSn')
  String get breakerSn;
  @override
  @JsonKey(name: 'addr')
  String get addr;
  @override
  @JsonKey(name: 'state')
  String get state;
  @override
  @JsonKey(name: 'rlySta')
  int get rlySta;
  @override
  @JsonKey(name: 'rlyRepSta')
  int get rlyRepSta;
  @override
  @JsonKey(name: 'lockSta')
  int get lockSta;
  @override
  @JsonKey(name: 'updatedAt')
  DateTime? get updatedAt;

  /// Create a copy of BreakerStateResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BreakerStateResponseImplCopyWith<_$BreakerStateResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
