// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'electric_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ElectricState {
  Result<ElectricMeter> get response => throw _privateConstructorUsedError;
  LoadStatus get loadStatus => throw _privateConstructorUsedError;

  /// Create a copy of ElectricState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ElectricStateCopyWith<ElectricState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ElectricStateCopyWith<$Res> {
  factory $ElectricStateCopyWith(
          ElectricState value, $Res Function(ElectricState) then) =
      _$ElectricStateCopyWithImpl<$Res, ElectricState>;
  @useResult
  $Res call({Result<ElectricMeter> response, LoadStatus loadStatus});

  $ResultCopyWith<ElectricMeter, $Res> get response;
}

/// @nodoc
class _$ElectricStateCopyWithImpl<$Res, $Val extends ElectricState>
    implements $ElectricStateCopyWith<$Res> {
  _$ElectricStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ElectricState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
    Object? loadStatus = null,
  }) {
    return _then(_value.copyWith(
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as Result<ElectricMeter>,
      loadStatus: null == loadStatus
          ? _value.loadStatus
          : loadStatus // ignore: cast_nullable_to_non_nullable
              as LoadStatus,
    ) as $Val);
  }

  /// Create a copy of ElectricState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ResultCopyWith<ElectricMeter, $Res> get response {
    return $ResultCopyWith<ElectricMeter, $Res>(_value.response, (value) {
      return _then(_value.copyWith(response: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ElectricStateImplCopyWith<$Res>
    implements $ElectricStateCopyWith<$Res> {
  factory _$$ElectricStateImplCopyWith(
          _$ElectricStateImpl value, $Res Function(_$ElectricStateImpl) then) =
      __$$ElectricStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Result<ElectricMeter> response, LoadStatus loadStatus});

  @override
  $ResultCopyWith<ElectricMeter, $Res> get response;
}

/// @nodoc
class __$$ElectricStateImplCopyWithImpl<$Res>
    extends _$ElectricStateCopyWithImpl<$Res, _$ElectricStateImpl>
    implements _$$ElectricStateImplCopyWith<$Res> {
  __$$ElectricStateImplCopyWithImpl(
      _$ElectricStateImpl _value, $Res Function(_$ElectricStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ElectricState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
    Object? loadStatus = null,
  }) {
    return _then(_$ElectricStateImpl(
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as Result<ElectricMeter>,
      loadStatus: null == loadStatus
          ? _value.loadStatus
          : loadStatus // ignore: cast_nullable_to_non_nullable
              as LoadStatus,
    ));
  }
}

/// @nodoc

class _$ElectricStateImpl implements _ElectricState {
  const _$ElectricStateImpl(
      {required this.response, this.loadStatus = LoadStatus.initial});

  @override
  final Result<ElectricMeter> response;
  @override
  @JsonKey()
  final LoadStatus loadStatus;

  @override
  String toString() {
    return 'ElectricState(response: $response, loadStatus: $loadStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ElectricStateImpl &&
            (identical(other.response, response) ||
                other.response == response) &&
            (identical(other.loadStatus, loadStatus) ||
                other.loadStatus == loadStatus));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response, loadStatus);

  /// Create a copy of ElectricState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ElectricStateImplCopyWith<_$ElectricStateImpl> get copyWith =>
      __$$ElectricStateImplCopyWithImpl<_$ElectricStateImpl>(this, _$identity);
}

abstract class _ElectricState implements ElectricState {
  const factory _ElectricState(
      {required final Result<ElectricMeter> response,
      final LoadStatus loadStatus}) = _$ElectricStateImpl;

  @override
  Result<ElectricMeter> get response;
  @override
  LoadStatus get loadStatus;

  /// Create a copy of ElectricState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ElectricStateImplCopyWith<_$ElectricStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
