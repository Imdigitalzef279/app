// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'atomat_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AtomatDetailState {
  LoadStatus get load => throw _privateConstructorUsedError;
  AtomatLogResponse? get logData => throw _privateConstructorUsedError;
  List<AtomatLogResponse>? get logList => throw _privateConstructorUsedError;
  BreakerStateResponse? get breakerState => throw _privateConstructorUsedError;

  /// Create a copy of AtomatDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AtomatDetailStateCopyWith<AtomatDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AtomatDetailStateCopyWith<$Res> {
  factory $AtomatDetailStateCopyWith(
          AtomatDetailState value, $Res Function(AtomatDetailState) then) =
      _$AtomatDetailStateCopyWithImpl<$Res, AtomatDetailState>;
  @useResult
  $Res call(
      {LoadStatus load,
      AtomatLogResponse? logData,
      List<AtomatLogResponse>? logList,
      BreakerStateResponse? breakerState});

  $AtomatLogResponseCopyWith<$Res>? get logData;
  $BreakerStateResponseCopyWith<$Res>? get breakerState;
}

/// @nodoc
class _$AtomatDetailStateCopyWithImpl<$Res, $Val extends AtomatDetailState>
    implements $AtomatDetailStateCopyWith<$Res> {
  _$AtomatDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AtomatDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? load = null,
    Object? logData = freezed,
    Object? logList = freezed,
    Object? breakerState = freezed,
  }) {
    return _then(_value.copyWith(
      load: null == load
          ? _value.load
          : load // ignore: cast_nullable_to_non_nullable
              as LoadStatus,
      logData: freezed == logData
          ? _value.logData
          : logData // ignore: cast_nullable_to_non_nullable
              as AtomatLogResponse?,
      logList: freezed == logList
          ? _value.logList
          : logList // ignore: cast_nullable_to_non_nullable
              as List<AtomatLogResponse>?,
      breakerState: freezed == breakerState
          ? _value.breakerState
          : breakerState // ignore: cast_nullable_to_non_nullable
              as BreakerStateResponse?,
    ) as $Val);
  }

  /// Create a copy of AtomatDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AtomatLogResponseCopyWith<$Res>? get logData {
    if (_value.logData == null) {
      return null;
    }

    return $AtomatLogResponseCopyWith<$Res>(_value.logData!, (value) {
      return _then(_value.copyWith(logData: value) as $Val);
    });
  }

  /// Create a copy of AtomatDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BreakerStateResponseCopyWith<$Res>? get breakerState {
    if (_value.breakerState == null) {
      return null;
    }

    return $BreakerStateResponseCopyWith<$Res>(_value.breakerState!, (value) {
      return _then(_value.copyWith(breakerState: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AtomatDetailStateImplCopyWith<$Res>
    implements $AtomatDetailStateCopyWith<$Res> {
  factory _$$AtomatDetailStateImplCopyWith(_$AtomatDetailStateImpl value,
          $Res Function(_$AtomatDetailStateImpl) then) =
      __$$AtomatDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LoadStatus load,
      AtomatLogResponse? logData,
      List<AtomatLogResponse>? logList,
      BreakerStateResponse? breakerState});

  @override
  $AtomatLogResponseCopyWith<$Res>? get logData;
  @override
  $BreakerStateResponseCopyWith<$Res>? get breakerState;
}

/// @nodoc
class __$$AtomatDetailStateImplCopyWithImpl<$Res>
    extends _$AtomatDetailStateCopyWithImpl<$Res, _$AtomatDetailStateImpl>
    implements _$$AtomatDetailStateImplCopyWith<$Res> {
  __$$AtomatDetailStateImplCopyWithImpl(_$AtomatDetailStateImpl _value,
      $Res Function(_$AtomatDetailStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AtomatDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? load = null,
    Object? logData = freezed,
    Object? logList = freezed,
    Object? breakerState = freezed,
  }) {
    return _then(_$AtomatDetailStateImpl(
      load: null == load
          ? _value.load
          : load // ignore: cast_nullable_to_non_nullable
              as LoadStatus,
      logData: freezed == logData
          ? _value.logData
          : logData // ignore: cast_nullable_to_non_nullable
              as AtomatLogResponse?,
      logList: freezed == logList
          ? _value._logList
          : logList // ignore: cast_nullable_to_non_nullable
              as List<AtomatLogResponse>?,
      breakerState: freezed == breakerState
          ? _value.breakerState
          : breakerState // ignore: cast_nullable_to_non_nullable
              as BreakerStateResponse?,
    ));
  }
}

/// @nodoc

class _$AtomatDetailStateImpl implements _AtomatDetailState {
  const _$AtomatDetailStateImpl(
      {this.load = LoadStatus.initial,
      this.logData,
      final List<AtomatLogResponse>? logList,
      this.breakerState})
      : _logList = logList;

  @override
  @JsonKey()
  final LoadStatus load;
  @override
  final AtomatLogResponse? logData;
  final List<AtomatLogResponse>? _logList;
  @override
  List<AtomatLogResponse>? get logList {
    final value = _logList;
    if (value == null) return null;
    if (_logList is EqualUnmodifiableListView) return _logList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final BreakerStateResponse? breakerState;

  @override
  String toString() {
    return 'AtomatDetailState(load: $load, logData: $logData, logList: $logList, breakerState: $breakerState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AtomatDetailStateImpl &&
            (identical(other.load, load) || other.load == load) &&
            (identical(other.logData, logData) || other.logData == logData) &&
            const DeepCollectionEquality().equals(other._logList, _logList) &&
            (identical(other.breakerState, breakerState) ||
                other.breakerState == breakerState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, load, logData,
      const DeepCollectionEquality().hash(_logList), breakerState);

  /// Create a copy of AtomatDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AtomatDetailStateImplCopyWith<_$AtomatDetailStateImpl> get copyWith =>
      __$$AtomatDetailStateImplCopyWithImpl<_$AtomatDetailStateImpl>(
          this, _$identity);
}

abstract class _AtomatDetailState implements AtomatDetailState {
  const factory _AtomatDetailState(
      {final LoadStatus load,
      final AtomatLogResponse? logData,
      final List<AtomatLogResponse>? logList,
      final BreakerStateResponse? breakerState}) = _$AtomatDetailStateImpl;

  @override
  LoadStatus get load;
  @override
  AtomatLogResponse? get logData;
  @override
  List<AtomatLogResponse>? get logList;
  @override
  BreakerStateResponse? get breakerState;

  /// Create a copy of AtomatDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AtomatDetailStateImplCopyWith<_$AtomatDetailStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
