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
  bool get isForceLoading => throw _privateConstructorUsedError;
  /// switching theo device
  Map<int, bool> get switchingDevices => throw _privateConstructorUsedError;
  /// countdown theo device
  Map<int, int> get switchCountdowns => throw _privateConstructorUsedError;
  /// log theo breakerSn
  Map<String, AtomatLogResponse> get breakerLogs =>
      throw _privateConstructorUsedError;
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
      Map<int, bool> switchingDevices,
      Map<int, int> switchCountdowns,
      Map<String, AtomatLogResponse> breakerLogs});

  $ResultCopyWith<List<DeviceResponse>, $Res> get resultDevices;
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
    Object? switchingDevices = null,
    Object? switchCountdowns = null,
    Object? breakerLogs = null,
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
      switchingDevices: null == switchingDevices
          ? _value.switchingDevices
          : switchingDevices // ignore: cast_nullable_to_non_nullable
              as Map<int, bool>,
      switchCountdowns: null == switchCountdowns
          ? _value.switchCountdowns
          : switchCountdowns // ignore: cast_nullable_to_non_nullable
              as Map<int, int>,
      breakerLogs: null == breakerLogs
          ? _value.breakerLogs
          : breakerLogs // ignore: cast_nullable_to_non_nullable
              as Map<String, AtomatLogResponse>,
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
      Map<int, bool> switchingDevices,
      Map<int, int> switchCountdowns,
      Map<String, AtomatLogResponse> breakerLogs});

  @override
  $ResultCopyWith<List<DeviceResponse>, $Res> get resultDevices;
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
    Object? switchingDevices = null,
    Object? switchCountdowns = null,
    Object? breakerLogs = null,
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
      switchingDevices: null == switchingDevices
          ? _value._switchingDevices
          : switchingDevices // ignore: cast_nullable_to_non_nullable
              as Map<int, bool>,
      switchCountdowns: null == switchCountdowns
          ? _value._switchCountdowns
          : switchCountdowns // ignore: cast_nullable_to_non_nullable
              as Map<int, int>,
      breakerLogs: null == breakerLogs
          ? _value._breakerLogs
          : breakerLogs // ignore: cast_nullable_to_non_nullable
              as Map<String, AtomatLogResponse>,
    ));
  }
}

/// @nodoc

class _$DeviceStateImpl implements _DeviceState {
  const _$DeviceStateImpl(
      {required this.resultDevices,
      this.status = LoadStatus.initial,
      this.isForceLoading = false,
      final Map<int, bool> switchingDevices = const {},
      final Map<int, int> switchCountdowns = const {},
      final Map<String, AtomatLogResponse> breakerLogs = const {}})
      : _switchingDevices = switchingDevices,
        _switchCountdowns = switchCountdowns,
        _breakerLogs = breakerLogs;

  @override
  final Result<List<DeviceResponse>> resultDevices;
  @override
  @JsonKey()
  final LoadStatus status;
  @override
  @JsonKey()
  final bool isForceLoading;

  /// switching theo device
  final Map<int, bool> _switchingDevices;

  /// switching theo device
  @override
  @JsonKey()
  Map<int, bool> get switchingDevices {
    if (_switchingDevices is EqualUnmodifiableMapView) return _switchingDevices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_switchingDevices);
  }

  /// countdown theo device
  final Map<int, int> _switchCountdowns;

  /// countdown theo device
  @override
  @JsonKey()
  Map<int, int> get switchCountdowns {
    if (_switchCountdowns is EqualUnmodifiableMapView) return _switchCountdowns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_switchCountdowns);
  }

  /// log theo breakerSn
  final Map<String, AtomatLogResponse> _breakerLogs;

  /// log theo breakerSn
  @override
  @JsonKey()
  Map<String, AtomatLogResponse> get breakerLogs {
    if (_breakerLogs is EqualUnmodifiableMapView) return _breakerLogs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_breakerLogs);
  }

  @override
  String toString() {
    return 'DeviceState(resultDevices: $resultDevices, status: $status, isForceLoading: $isForceLoading, switchingDevices: $switchingDevices, switchCountdowns: $switchCountdowns, breakerLogs: $breakerLogs)';
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
            const DeepCollectionEquality()
                .equals(other._switchingDevices, _switchingDevices) &&
            const DeepCollectionEquality()
                .equals(other._switchCountdowns, _switchCountdowns) &&
            const DeepCollectionEquality()
                .equals(other._breakerLogs, _breakerLogs));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      resultDevices,
      status,
      isForceLoading,
      const DeepCollectionEquality().hash(_switchingDevices),
      const DeepCollectionEquality().hash(_switchCountdowns),
      const DeepCollectionEquality().hash(_breakerLogs));

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
      final Map<int, bool> switchingDevices,
      final Map<int, int> switchCountdowns,
      final Map<String, AtomatLogResponse> breakerLogs}) = _$DeviceStateImpl;

  @override
  Result<List<DeviceResponse>> get resultDevices;
  @override
  LoadStatus get status;
  @override
  bool get isForceLoading;

  /// switching theo device
  @override
  Map<int, bool> get switchingDevices;

  /// countdown theo device
  @override
  Map<int, int> get switchCountdowns;

  /// log theo breakerSn
  @override
  Map<String, AtomatLogResponse> get breakerLogs;

  /// Create a copy of DeviceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeviceStateImplCopyWith<_$DeviceStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
