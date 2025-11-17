// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meter_water_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MeterWaterResponse _$MeterWaterResponseFromJson(Map<String, dynamic> json) {
  return _MeterWaterResponse.fromJson(json);
}

/// @nodoc
mixin _$MeterWaterResponse {
  int get id => throw _privateConstructorUsedError;
  int get meterCode => throw _privateConstructorUsedError;
  String get updateTime => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  String get state => throw _privateConstructorUsedError;

  /// Serializes this MeterWaterResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MeterWaterResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MeterWaterResponseCopyWith<MeterWaterResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeterWaterResponseCopyWith<$Res> {
  factory $MeterWaterResponseCopyWith(
          MeterWaterResponse value, $Res Function(MeterWaterResponse) then) =
      _$MeterWaterResponseCopyWithImpl<$Res, MeterWaterResponse>;
  @useResult
  $Res call(
      {int id, int meterCode, String updateTime, String value, String state});
}

/// @nodoc
class _$MeterWaterResponseCopyWithImpl<$Res, $Val extends MeterWaterResponse>
    implements $MeterWaterResponseCopyWith<$Res> {
  _$MeterWaterResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MeterWaterResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? meterCode = null,
    Object? updateTime = null,
    Object? value = null,
    Object? state = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      meterCode: null == meterCode
          ? _value.meterCode
          : meterCode // ignore: cast_nullable_to_non_nullable
              as int,
      updateTime: null == updateTime
          ? _value.updateTime
          : updateTime // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MeterWaterResponseImplCopyWith<$Res>
    implements $MeterWaterResponseCopyWith<$Res> {
  factory _$$MeterWaterResponseImplCopyWith(_$MeterWaterResponseImpl value,
          $Res Function(_$MeterWaterResponseImpl) then) =
      __$$MeterWaterResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id, int meterCode, String updateTime, String value, String state});
}

/// @nodoc
class __$$MeterWaterResponseImplCopyWithImpl<$Res>
    extends _$MeterWaterResponseCopyWithImpl<$Res, _$MeterWaterResponseImpl>
    implements _$$MeterWaterResponseImplCopyWith<$Res> {
  __$$MeterWaterResponseImplCopyWithImpl(_$MeterWaterResponseImpl _value,
      $Res Function(_$MeterWaterResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of MeterWaterResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? meterCode = null,
    Object? updateTime = null,
    Object? value = null,
    Object? state = null,
  }) {
    return _then(_$MeterWaterResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      meterCode: null == meterCode
          ? _value.meterCode
          : meterCode // ignore: cast_nullable_to_non_nullable
              as int,
      updateTime: null == updateTime
          ? _value.updateTime
          : updateTime // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MeterWaterResponseImpl implements _MeterWaterResponse {
  const _$MeterWaterResponseImpl(
      {this.id = 0,
      this.meterCode = 0,
      this.updateTime = "",
      this.value = "",
      this.state = ""});

  factory _$MeterWaterResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MeterWaterResponseImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final int meterCode;
  @override
  @JsonKey()
  final String updateTime;
  @override
  @JsonKey()
  final String value;
  @override
  @JsonKey()
  final String state;

  @override
  String toString() {
    return 'MeterWaterResponse(id: $id, meterCode: $meterCode, updateTime: $updateTime, value: $value, state: $state)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeterWaterResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.meterCode, meterCode) ||
                other.meterCode == meterCode) &&
            (identical(other.updateTime, updateTime) ||
                other.updateTime == updateTime) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.state, state) || other.state == state));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, meterCode, updateTime, value, state);

  /// Create a copy of MeterWaterResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MeterWaterResponseImplCopyWith<_$MeterWaterResponseImpl> get copyWith =>
      __$$MeterWaterResponseImplCopyWithImpl<_$MeterWaterResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MeterWaterResponseImplToJson(
      this,
    );
  }
}

abstract class _MeterWaterResponse implements MeterWaterResponse {
  const factory _MeterWaterResponse(
      {final int id,
      final int meterCode,
      final String updateTime,
      final String value,
      final String state}) = _$MeterWaterResponseImpl;

  factory _MeterWaterResponse.fromJson(Map<String, dynamic> json) =
      _$MeterWaterResponseImpl.fromJson;

  @override
  int get id;
  @override
  int get meterCode;
  @override
  String get updateTime;
  @override
  String get value;
  @override
  String get state;

  /// Create a copy of MeterWaterResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MeterWaterResponseImplCopyWith<_$MeterWaterResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
