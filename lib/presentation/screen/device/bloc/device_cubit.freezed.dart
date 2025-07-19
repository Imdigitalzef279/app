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
  $Res call({Result<List<DeviceResponse>> resultDevices, LoadStatus status});

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
  $Res call({Result<List<DeviceResponse>> resultDevices, LoadStatus status});

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
    ));
  }
}

/// @nodoc

class _$DeviceStateImpl implements _DeviceState {
  const _$DeviceStateImpl(
      {required this.resultDevices, this.status = LoadStatus.initial});

  @override
  final Result<List<DeviceResponse>> resultDevices;
  @override
  @JsonKey()
  final LoadStatus status;

  @override
  String toString() {
    return 'DeviceState(resultDevices: $resultDevices, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceStateImpl &&
            (identical(other.resultDevices, resultDevices) ||
                other.resultDevices == resultDevices) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, resultDevices, status);

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
      final LoadStatus status}) = _$DeviceStateImpl;

  @override
  Result<List<DeviceResponse>> get resultDevices;
  @override
  LoadStatus get status;

  /// Create a copy of DeviceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeviceStateImplCopyWith<_$DeviceStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
