// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'electric_meter_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ElectricMeter _$ElectricMeterFromJson(Map<String, dynamic> json) {
  return _ElectricMeter.fromJson(json);
}

/// @nodoc
mixin _$ElectricMeter {
  MeterResponse get meter => throw _privateConstructorUsedError;
  LastedLogDataResponse get lastedLogData => throw _privateConstructorUsedError;

  /// Serializes this ElectricMeter to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ElectricMeter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ElectricMeterCopyWith<ElectricMeter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ElectricMeterCopyWith<$Res> {
  factory $ElectricMeterCopyWith(
          ElectricMeter value, $Res Function(ElectricMeter) then) =
      _$ElectricMeterCopyWithImpl<$Res, ElectricMeter>;
  @useResult
  $Res call({MeterResponse meter, LastedLogDataResponse lastedLogData});

  $MeterResponseCopyWith<$Res> get meter;
  $LastedLogDataResponseCopyWith<$Res> get lastedLogData;
}

/// @nodoc
class _$ElectricMeterCopyWithImpl<$Res, $Val extends ElectricMeter>
    implements $ElectricMeterCopyWith<$Res> {
  _$ElectricMeterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ElectricMeter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meter = null,
    Object? lastedLogData = null,
  }) {
    return _then(_value.copyWith(
      meter: null == meter
          ? _value.meter
          : meter // ignore: cast_nullable_to_non_nullable
              as MeterResponse,
      lastedLogData: null == lastedLogData
          ? _value.lastedLogData
          : lastedLogData // ignore: cast_nullable_to_non_nullable
              as LastedLogDataResponse,
    ) as $Val);
  }

  /// Create a copy of ElectricMeter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MeterResponseCopyWith<$Res> get meter {
    return $MeterResponseCopyWith<$Res>(_value.meter, (value) {
      return _then(_value.copyWith(meter: value) as $Val);
    });
  }

  /// Create a copy of ElectricMeter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LastedLogDataResponseCopyWith<$Res> get lastedLogData {
    return $LastedLogDataResponseCopyWith<$Res>(_value.lastedLogData, (value) {
      return _then(_value.copyWith(lastedLogData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ElectricMeterImplCopyWith<$Res>
    implements $ElectricMeterCopyWith<$Res> {
  factory _$$ElectricMeterImplCopyWith(
          _$ElectricMeterImpl value, $Res Function(_$ElectricMeterImpl) then) =
      __$$ElectricMeterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({MeterResponse meter, LastedLogDataResponse lastedLogData});

  @override
  $MeterResponseCopyWith<$Res> get meter;
  @override
  $LastedLogDataResponseCopyWith<$Res> get lastedLogData;
}

/// @nodoc
class __$$ElectricMeterImplCopyWithImpl<$Res>
    extends _$ElectricMeterCopyWithImpl<$Res, _$ElectricMeterImpl>
    implements _$$ElectricMeterImplCopyWith<$Res> {
  __$$ElectricMeterImplCopyWithImpl(
      _$ElectricMeterImpl _value, $Res Function(_$ElectricMeterImpl) _then)
      : super(_value, _then);

  /// Create a copy of ElectricMeter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meter = null,
    Object? lastedLogData = null,
  }) {
    return _then(_$ElectricMeterImpl(
      meter: null == meter
          ? _value.meter
          : meter // ignore: cast_nullable_to_non_nullable
              as MeterResponse,
      lastedLogData: null == lastedLogData
          ? _value.lastedLogData
          : lastedLogData // ignore: cast_nullable_to_non_nullable
              as LastedLogDataResponse,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ElectricMeterImpl implements _ElectricMeter {
  const _$ElectricMeterImpl(
      {this.meter = const MeterResponse(),
      this.lastedLogData = const LastedLogDataResponse()});

  factory _$ElectricMeterImpl.fromJson(Map<String, dynamic> json) =>
      _$$ElectricMeterImplFromJson(json);

  @override
  @JsonKey()
  final MeterResponse meter;
  @override
  @JsonKey()
  final LastedLogDataResponse lastedLogData;

  @override
  String toString() {
    return 'ElectricMeter(meter: $meter, lastedLogData: $lastedLogData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ElectricMeterImpl &&
            (identical(other.meter, meter) || other.meter == meter) &&
            (identical(other.lastedLogData, lastedLogData) ||
                other.lastedLogData == lastedLogData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, meter, lastedLogData);

  /// Create a copy of ElectricMeter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ElectricMeterImplCopyWith<_$ElectricMeterImpl> get copyWith =>
      __$$ElectricMeterImplCopyWithImpl<_$ElectricMeterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ElectricMeterImplToJson(
      this,
    );
  }
}

abstract class _ElectricMeter implements ElectricMeter {
  const factory _ElectricMeter(
      {final MeterResponse meter,
      final LastedLogDataResponse lastedLogData}) = _$ElectricMeterImpl;

  factory _ElectricMeter.fromJson(Map<String, dynamic> json) =
      _$ElectricMeterImpl.fromJson;

  @override
  MeterResponse get meter;
  @override
  LastedLogDataResponse get lastedLogData;

  /// Create a copy of ElectricMeter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ElectricMeterImplCopyWith<_$ElectricMeterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
