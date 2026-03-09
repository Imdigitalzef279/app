// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DeviceState {
  Result<List<DeviceResponse>> get resultDevices =>
      throw _privateConstructorUsedError;
  LoadStatus get status => throw _privateConstructorUsedError;

  /// loading cho FORCE
  bool get isForceLoading => throw _privateConstructorUsedError;

  /// loading cho ON/OFF
  bool get isSwitching => throw _privateConstructorUsedError;

  /// countdown cho breaker
  int get switchCountdown => throw _privateConstructorUsedError;
  AtomatLogResponse? get breakerLog => throw _privateConstructorUsedError;

  /// Create a copy of DeviceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeviceStateCopyWith<DeviceState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceStateCopyWith<$Res> {
  factory $DeviceStateCopyWith(
          DeviceState value, $Res Function(DeviceState) then) =
      _$DeviceStateCopyWithImpl<$Res, DeviceState>;
  @useResult
  $Res call(
      {Result<List<DeviceResponse>> resultDevices,
      LoadStatus status,
      bool isForceLoading,
      bool isSwitching,
      int switchCountdown,
      AtomatLogResponse? breakerLog});

  $ResultCopyWith<List<DeviceResponse>, $Res> get resultDevices;
  $AtomatLogResponseCopyWith<$Res>? get breakerLog;
}

/// @nodoc
class _$DeviceStateCopyWithImpl<$Res, $Val extends DeviceState>
    implements $DeviceStateCopyWith<$Res> {
  _$DeviceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeviceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultDevices = null,
    Object? status = null,
    Object? isForceLoading = null,
    Object? isSwitching = null,
    Object? switchCountdown = null,
    Object? breakerLog = freezed,
  }) {
    return _then(_value.copyWith(
      resultDevices: null == resultDevices
          ? _value.resultDevices
          : resultDevices // ignore: cast_nullable_to_non_nullable
              as Result<List<DeviceResponse>>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LoadStatus,
      isForceLoading: null == isForceLoading
          ? _value.isForceLoading
          : isForceLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSwitching: null == isSwitching
          ? _value.isSwitching
          : isSwitching // ignore: cast_nullable_to_non_nullable
              as bool,
      switchCountdown: null == switchCountdown
          ? _value.switchCountdown
          : switchCountdown // ignore: cast_nullable_to_non_nullable
              as int,
      breakerLog: freezed == breakerLog
          ? _value.breakerLog
          : breakerLog // ignore: cast_nullable_to_non_nullable
              as AtomatLogResponse?,
    ) as $Val);
  }

  /// Create a copy of DeviceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ResultCopyWith<List<DeviceResponse>, $Res> get resultDevices {
    return $ResultCopyWith<List<DeviceResponse>, $Res>(_value.resultDevices,
        (value) {
      return _then(_value.copyWith(resultDevices: value) as $Val);
    });
  }

  /// Create a copy of DeviceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AtomatLogResponseCopyWith<$Res>? get breakerLog {
    if (_value.breakerLog == null) {
      return null;
    }

    return $AtomatLogResponseCopyWith<$Res>(_value.breakerLog!, (value) {
      return _then(_value.copyWith(breakerLog: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DeviceStateImplCopyWith<$Res>
    implements $DeviceStateCopyWith<$Res> {
  factory _$$DeviceStateImplCopyWith(
          _$DeviceStateImpl value, $Res Function(_$DeviceStateImpl) then) =
      __$$DeviceStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Result<List<DeviceResponse>> resultDevices,
      LoadStatus status,
      bool isForceLoading,
      bool isSwitching,
      int switchCountdown,
      AtomatLogResponse? breakerLog});

  @override
  $ResultCopyWith<List<DeviceResponse>, $Res> get resultDevices;
  @override
  $AtomatLogResponseCopyWith<$Res>? get breakerLog;
}

/// @nodoc
class __$$DeviceStateImplCopyWithImpl<$Res>
    extends _$DeviceStateCopyWithImpl<$Res, _$DeviceStateImpl>
    implements _$$DeviceStateImplCopyWith<$Res> {
  __$$DeviceStateImplCopyWithImpl(
      _$DeviceStateImpl _value, $Res Function(_$DeviceStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeviceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultDevices = null,
    Object? status = null,
    Object? isForceLoading = null,
    Object? isSwitching = null,
    Object? switchCountdown = null,
    Object? breakerLog = freezed,
  }) {
    return _then(_$DeviceStateImpl(
      resultDevices: null == resultDevices
          ? _value.resultDevices
          : resultDevices // ignore: cast_nullable_to_non_nullable
              as Result<List<DeviceResponse>>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LoadStatus,
      isForceLoading: null == isForceLoading
          ? _value.isForceLoading
          : isForceLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSwitching: null == isSwitching
          ? _value.isSwitching
          : isSwitching // ignore: cast_nullable_to_non_nullable
              as bool,
      switchCountdown: null == switchCountdown
          ? _value.switchCountdown
          : switchCountdown // ignore: cast_nullable_to_non_nullable
              as int,
      breakerLog: freezed == breakerLog
          ? _value.breakerLog
          : breakerLog // ignore: cast_nullable_to_non_nullable
              as AtomatLogResponse?,
    ));
  }
}

/// @nodoc

class _$DeviceStateImpl implements _DeviceState {
  const _$DeviceStateImpl(
      {required this.resultDevices,
      this.status = LoadStatus.initial,
      this.isForceLoading = false,
      this.isSwitching = false,
      this.switchCountdown = 0,
      this.breakerLog});

  @override
  final Result<List<DeviceResponse>> resultDevices;
  @override
  @JsonKey()
  final LoadStatus status;

  /// loading cho FORCE
  @override
  @JsonKey()
  final bool isForceLoading;

  /// loading cho ON/OFF
  @override
  @JsonKey()
  final bool isSwitching;

  /// countdown cho breaker
  @override
  @JsonKey()
  final int switchCountdown;
  @override
  final AtomatLogResponse? breakerLog;

  @override
  String toString() {
    return 'DeviceState(resultDevices: $resultDevices, status: $status, isForceLoading: $isForceLoading, isSwitching: $isSwitching, switchCountdown: $switchCountdown, breakerLog: $breakerLog)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceStateImpl &&
            (identical(other.resultDevices, resultDevices) ||
                other.resultDevices == resultDevices) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isForceLoading, isForceLoading) ||
                other.isForceLoading == isForceLoading) &&
            (identical(other.isSwitching, isSwitching) ||
                other.isSwitching == isSwitching) &&
            (identical(other.switchCountdown, switchCountdown) ||
                other.switchCountdown == switchCountdown) &&
            (identical(other.breakerLog, breakerLog) ||
                other.breakerLog == breakerLog));
  }

  @override
  int get hashCode => Object.hash(runtimeType, resultDevices, status,
      isForceLoading, isSwitching, switchCountdown, breakerLog);

  /// Create a copy of DeviceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceStateImplCopyWith<_$DeviceStateImpl> get copyWith =>
      __$$DeviceStateImplCopyWithImpl<_$DeviceStateImpl>(this, _$identity);
}

abstract class _DeviceState implements DeviceState {
  const factory _DeviceState(
      {required final Result<List<DeviceResponse>> resultDevices,
      final LoadStatus status,
      final bool isForceLoading,
      final bool isSwitching,
      final int switchCountdown,
      final AtomatLogResponse? breakerLog}) = _$DeviceStateImpl;

  @override
  Result<List<DeviceResponse>> get resultDevices;
  @override
  LoadStatus get status;

  /// loading cho FORCE
  @override
  bool get isForceLoading;

  /// loading cho ON/OFF
  @override
  bool get isSwitching;

  /// countdown cho breaker
  @override
  int get switchCountdown;
  @override
  AtomatLogResponse? get breakerLog;

  /// Create a copy of DeviceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeviceStateImplCopyWith<_$DeviceStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
