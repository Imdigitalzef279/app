// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alarm_meter_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AlarmMeterResponse _$AlarmMeterResponseFromJson(Map<String, dynamic> json) {
  return _AlarmMeterResponse.fromJson(json);
}

/// @nodoc
mixin _$AlarmMeterResponse {
  int get id => throw _privateConstructorUsedError;
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'meterDto')
  MeterResponse get meter => throw _privateConstructorUsedError;
  @JsonKey(name: 'alarmConfigDto')
  AlarmConfigResponse get alarmConfig => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  DateTime? get creationTime => throw _privateConstructorUsedError;
  DateTime? get resolvedTime => throw _privateConstructorUsedError;

  /// Serializes this AlarmMeterResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AlarmMeterResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AlarmMeterResponseCopyWith<AlarmMeterResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlarmMeterResponseCopyWith<$Res> {
  factory $AlarmMeterResponseCopyWith(
          AlarmMeterResponse value, $Res Function(AlarmMeterResponse) then) =
      _$AlarmMeterResponseCopyWithImpl<$Res, AlarmMeterResponse>;
  @useResult
  $Res call(
      {int id,
      int status,
      @JsonKey(name: 'meterDto') MeterResponse meter,
      @JsonKey(name: 'alarmConfigDto') AlarmConfigResponse alarmConfig,
      String message,
      String reason,
      DateTime? creationTime,
      DateTime? resolvedTime});

  $MeterResponseCopyWith<$Res> get meter;
  $AlarmConfigResponseCopyWith<$Res> get alarmConfig;
}

/// @nodoc
class _$AlarmMeterResponseCopyWithImpl<$Res, $Val extends AlarmMeterResponse>
    implements $AlarmMeterResponseCopyWith<$Res> {
  _$AlarmMeterResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AlarmMeterResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? meter = null,
    Object? alarmConfig = null,
    Object? message = null,
    Object? reason = null,
    Object? creationTime = freezed,
    Object? resolvedTime = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      meter: null == meter
          ? _value.meter
          : meter // ignore: cast_nullable_to_non_nullable
              as MeterResponse,
      alarmConfig: null == alarmConfig
          ? _value.alarmConfig
          : alarmConfig // ignore: cast_nullable_to_non_nullable
              as AlarmConfigResponse,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      creationTime: freezed == creationTime
          ? _value.creationTime
          : creationTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      resolvedTime: freezed == resolvedTime
          ? _value.resolvedTime
          : resolvedTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of AlarmMeterResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MeterResponseCopyWith<$Res> get meter {
    return $MeterResponseCopyWith<$Res>(_value.meter, (value) {
      return _then(_value.copyWith(meter: value) as $Val);
    });
  }

  /// Create a copy of AlarmMeterResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AlarmConfigResponseCopyWith<$Res> get alarmConfig {
    return $AlarmConfigResponseCopyWith<$Res>(_value.alarmConfig, (value) {
      return _then(_value.copyWith(alarmConfig: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AlarmMeterResponseImplCopyWith<$Res>
    implements $AlarmMeterResponseCopyWith<$Res> {
  factory _$$AlarmMeterResponseImplCopyWith(_$AlarmMeterResponseImpl value,
          $Res Function(_$AlarmMeterResponseImpl) then) =
      __$$AlarmMeterResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int status,
      @JsonKey(name: 'meterDto') MeterResponse meter,
      @JsonKey(name: 'alarmConfigDto') AlarmConfigResponse alarmConfig,
      String message,
      String reason,
      DateTime? creationTime,
      DateTime? resolvedTime});

  @override
  $MeterResponseCopyWith<$Res> get meter;
  @override
  $AlarmConfigResponseCopyWith<$Res> get alarmConfig;
}

/// @nodoc
class __$$AlarmMeterResponseImplCopyWithImpl<$Res>
    extends _$AlarmMeterResponseCopyWithImpl<$Res, _$AlarmMeterResponseImpl>
    implements _$$AlarmMeterResponseImplCopyWith<$Res> {
  __$$AlarmMeterResponseImplCopyWithImpl(_$AlarmMeterResponseImpl _value,
      $Res Function(_$AlarmMeterResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AlarmMeterResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? meter = null,
    Object? alarmConfig = null,
    Object? message = null,
    Object? reason = null,
    Object? creationTime = freezed,
    Object? resolvedTime = freezed,
  }) {
    return _then(_$AlarmMeterResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      meter: null == meter
          ? _value.meter
          : meter // ignore: cast_nullable_to_non_nullable
              as MeterResponse,
      alarmConfig: null == alarmConfig
          ? _value.alarmConfig
          : alarmConfig // ignore: cast_nullable_to_non_nullable
              as AlarmConfigResponse,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      creationTime: freezed == creationTime
          ? _value.creationTime
          : creationTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      resolvedTime: freezed == resolvedTime
          ? _value.resolvedTime
          : resolvedTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AlarmMeterResponseImpl implements _AlarmMeterResponse {
  const _$AlarmMeterResponseImpl(
      {this.id = 0,
      this.status = 0,
      @JsonKey(name: 'meterDto') this.meter = const MeterResponse(),
      @JsonKey(name: 'alarmConfigDto')
      this.alarmConfig = const AlarmConfigResponse(),
      this.message = '',
      this.reason = '',
      this.creationTime,
      this.resolvedTime});

  factory _$AlarmMeterResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlarmMeterResponseImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final int status;
  @override
  @JsonKey(name: 'meterDto')
  final MeterResponse meter;
  @override
  @JsonKey(name: 'alarmConfigDto')
  final AlarmConfigResponse alarmConfig;
  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey()
  final String reason;
  @override
  final DateTime? creationTime;
  @override
  final DateTime? resolvedTime;

  @override
  String toString() {
    return 'AlarmMeterResponse(id: $id, status: $status, meter: $meter, alarmConfig: $alarmConfig, message: $message, reason: $reason, creationTime: $creationTime, resolvedTime: $resolvedTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlarmMeterResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.meter, meter) || other.meter == meter) &&
            (identical(other.alarmConfig, alarmConfig) ||
                other.alarmConfig == alarmConfig) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.creationTime, creationTime) ||
                other.creationTime == creationTime) &&
            (identical(other.resolvedTime, resolvedTime) ||
                other.resolvedTime == resolvedTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, status, meter, alarmConfig,
      message, reason, creationTime, resolvedTime);

  /// Create a copy of AlarmMeterResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlarmMeterResponseImplCopyWith<_$AlarmMeterResponseImpl> get copyWith =>
      __$$AlarmMeterResponseImplCopyWithImpl<_$AlarmMeterResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlarmMeterResponseImplToJson(
      this,
    );
  }
}

abstract class _AlarmMeterResponse implements AlarmMeterResponse {
  const factory _AlarmMeterResponse(
      {final int id,
      final int status,
      @JsonKey(name: 'meterDto') final MeterResponse meter,
      @JsonKey(name: 'alarmConfigDto') final AlarmConfigResponse alarmConfig,
      final String message,
      final String reason,
      final DateTime? creationTime,
      final DateTime? resolvedTime}) = _$AlarmMeterResponseImpl;

  factory _AlarmMeterResponse.fromJson(Map<String, dynamic> json) =
      _$AlarmMeterResponseImpl.fromJson;

  @override
  int get id;
  @override
  int get status;
  @override
  @JsonKey(name: 'meterDto')
  MeterResponse get meter;
  @override
  @JsonKey(name: 'alarmConfigDto')
  AlarmConfigResponse get alarmConfig;
  @override
  String get message;
  @override
  String get reason;
  @override
  DateTime? get creationTime;
  @override
  DateTime? get resolvedTime;

  /// Create a copy of AlarmMeterResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlarmMeterResponseImplCopyWith<_$AlarmMeterResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
