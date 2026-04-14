// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alarm_config_meter_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AlarmConfigMeterResponse _$AlarmConfigMeterResponseFromJson(
    Map<String, dynamic> json) {
  return _AlarmConfigMeterResponse.fromJson(json);
}

/// @nodoc
mixin _$AlarmConfigMeterResponse {
  int get id => throw _privateConstructorUsedError;
  int get meterId => throw _privateConstructorUsedError;
  String get meterCode => throw _privateConstructorUsedError;
  String get thresholdValue => throw _privateConstructorUsedError;
  String get thresholdType => throw _privateConstructorUsedError;

  /// Serializes this AlarmConfigMeterResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AlarmConfigMeterResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AlarmConfigMeterResponseCopyWith<AlarmConfigMeterResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlarmConfigMeterResponseCopyWith<$Res> {
  factory $AlarmConfigMeterResponseCopyWith(AlarmConfigMeterResponse value,
          $Res Function(AlarmConfigMeterResponse) then) =
      _$AlarmConfigMeterResponseCopyWithImpl<$Res, AlarmConfigMeterResponse>;
  @useResult
  $Res call(
      {int id,
      int meterId,
      String meterCode,
      String thresholdValue,
      String thresholdType});
}

/// @nodoc
class _$AlarmConfigMeterResponseCopyWithImpl<$Res,
        $Val extends AlarmConfigMeterResponse>
    implements $AlarmConfigMeterResponseCopyWith<$Res> {
  _$AlarmConfigMeterResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AlarmConfigMeterResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? meterId = null,
    Object? meterCode = null,
    Object? thresholdValue = null,
    Object? thresholdType = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      meterId: null == meterId
          ? _value.meterId
          : meterId // ignore: cast_nullable_to_non_nullable
              as int,
      meterCode: null == meterCode
          ? _value.meterCode
          : meterCode // ignore: cast_nullable_to_non_nullable
              as String,
      thresholdValue: null == thresholdValue
          ? _value.thresholdValue
          : thresholdValue // ignore: cast_nullable_to_non_nullable
              as String,
      thresholdType: null == thresholdType
          ? _value.thresholdType
          : thresholdType // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AlarmConfigMeterResponseImplCopyWith<$Res>
    implements $AlarmConfigMeterResponseCopyWith<$Res> {
  factory _$$AlarmConfigMeterResponseImplCopyWith(
          _$AlarmConfigMeterResponseImpl value,
          $Res Function(_$AlarmConfigMeterResponseImpl) then) =
      __$$AlarmConfigMeterResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int meterId,
      String meterCode,
      String thresholdValue,
      String thresholdType});
}

/// @nodoc
class __$$AlarmConfigMeterResponseImplCopyWithImpl<$Res>
    extends _$AlarmConfigMeterResponseCopyWithImpl<$Res,
        _$AlarmConfigMeterResponseImpl>
    implements _$$AlarmConfigMeterResponseImplCopyWith<$Res> {
  __$$AlarmConfigMeterResponseImplCopyWithImpl(
      _$AlarmConfigMeterResponseImpl _value,
      $Res Function(_$AlarmConfigMeterResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AlarmConfigMeterResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? meterId = null,
    Object? meterCode = null,
    Object? thresholdValue = null,
    Object? thresholdType = null,
  }) {
    return _then(_$AlarmConfigMeterResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      meterId: null == meterId
          ? _value.meterId
          : meterId // ignore: cast_nullable_to_non_nullable
              as int,
      meterCode: null == meterCode
          ? _value.meterCode
          : meterCode // ignore: cast_nullable_to_non_nullable
              as String,
      thresholdValue: null == thresholdValue
          ? _value.thresholdValue
          : thresholdValue // ignore: cast_nullable_to_non_nullable
              as String,
      thresholdType: null == thresholdType
          ? _value.thresholdType
          : thresholdType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AlarmConfigMeterResponseImpl implements _AlarmConfigMeterResponse {
  const _$AlarmConfigMeterResponseImpl(
      {this.id = 0,
      this.meterId = 0,
      this.meterCode = '',
      this.thresholdValue = '',
      this.thresholdType = ''});

  factory _$AlarmConfigMeterResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlarmConfigMeterResponseImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final int meterId;
  @override
  @JsonKey()
  final String meterCode;
  @override
  @JsonKey()
  final String thresholdValue;
  @override
  @JsonKey()
  final String thresholdType;

  @override
  String toString() {
    return 'AlarmConfigMeterResponse(id: $id, meterId: $meterId, meterCode: $meterCode, thresholdValue: $thresholdValue, thresholdType: $thresholdType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlarmConfigMeterResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.meterId, meterId) || other.meterId == meterId) &&
            (identical(other.meterCode, meterCode) ||
                other.meterCode == meterCode) &&
            (identical(other.thresholdValue, thresholdValue) ||
                other.thresholdValue == thresholdValue) &&
            (identical(other.thresholdType, thresholdType) ||
                other.thresholdType == thresholdType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, meterId, meterCode, thresholdValue, thresholdType);

  /// Create a copy of AlarmConfigMeterResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlarmConfigMeterResponseImplCopyWith<_$AlarmConfigMeterResponseImpl>
      get copyWith => __$$AlarmConfigMeterResponseImplCopyWithImpl<
          _$AlarmConfigMeterResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlarmConfigMeterResponseImplToJson(
      this,
    );
  }
}

abstract class _AlarmConfigMeterResponse implements AlarmConfigMeterResponse {
  const factory _AlarmConfigMeterResponse(
      {final int id,
      final int meterId,
      final String meterCode,
      final String thresholdValue,
      final String thresholdType}) = _$AlarmConfigMeterResponseImpl;

  factory _AlarmConfigMeterResponse.fromJson(Map<String, dynamic> json) =
      _$AlarmConfigMeterResponseImpl.fromJson;

  @override
  int get id;
  @override
  int get meterId;
  @override
  String get meterCode;
  @override
  String get thresholdValue;
  @override
  String get thresholdType;

  /// Create a copy of AlarmConfigMeterResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlarmConfigMeterResponseImplCopyWith<_$AlarmConfigMeterResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
