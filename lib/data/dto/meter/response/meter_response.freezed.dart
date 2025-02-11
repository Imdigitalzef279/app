// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meter_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MeterResponse _$MeterResponseFromJson(Map<String, dynamic> json) {
  return _MeterResponse.fromJson(json);
}

/// @nodoc
mixin _$MeterResponse {
  int get id => throw _privateConstructorUsedError;
  int get status => throw _privateConstructorUsedError;
  MeterTypeResponse get meterType => throw _privateConstructorUsedError;
  PowerStationResponse get powerStation => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  /// Serializes this MeterResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MeterResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MeterResponseCopyWith<MeterResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeterResponseCopyWith<$Res> {
  factory $MeterResponseCopyWith(
          MeterResponse value, $Res Function(MeterResponse) then) =
      _$MeterResponseCopyWithImpl<$Res, MeterResponse>;
  @useResult
  $Res call(
      {int id,
      int status,
      MeterTypeResponse meterType,
      PowerStationResponse powerStation,
      String name,
      String code,
      String description});

  $MeterTypeResponseCopyWith<$Res> get meterType;
  $PowerStationResponseCopyWith<$Res> get powerStation;
}

/// @nodoc
class _$MeterResponseCopyWithImpl<$Res, $Val extends MeterResponse>
    implements $MeterResponseCopyWith<$Res> {
  _$MeterResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MeterResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? meterType = null,
    Object? powerStation = null,
    Object? name = null,
    Object? code = null,
    Object? description = null,
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
      meterType: null == meterType
          ? _value.meterType
          : meterType // ignore: cast_nullable_to_non_nullable
              as MeterTypeResponse,
      powerStation: null == powerStation
          ? _value.powerStation
          : powerStation // ignore: cast_nullable_to_non_nullable
              as PowerStationResponse,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of MeterResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MeterTypeResponseCopyWith<$Res> get meterType {
    return $MeterTypeResponseCopyWith<$Res>(_value.meterType, (value) {
      return _then(_value.copyWith(meterType: value) as $Val);
    });
  }

  /// Create a copy of MeterResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PowerStationResponseCopyWith<$Res> get powerStation {
    return $PowerStationResponseCopyWith<$Res>(_value.powerStation, (value) {
      return _then(_value.copyWith(powerStation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MeterResponseImplCopyWith<$Res>
    implements $MeterResponseCopyWith<$Res> {
  factory _$$MeterResponseImplCopyWith(
          _$MeterResponseImpl value, $Res Function(_$MeterResponseImpl) then) =
      __$$MeterResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int status,
      MeterTypeResponse meterType,
      PowerStationResponse powerStation,
      String name,
      String code,
      String description});

  @override
  $MeterTypeResponseCopyWith<$Res> get meterType;
  @override
  $PowerStationResponseCopyWith<$Res> get powerStation;
}

/// @nodoc
class __$$MeterResponseImplCopyWithImpl<$Res>
    extends _$MeterResponseCopyWithImpl<$Res, _$MeterResponseImpl>
    implements _$$MeterResponseImplCopyWith<$Res> {
  __$$MeterResponseImplCopyWithImpl(
      _$MeterResponseImpl _value, $Res Function(_$MeterResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of MeterResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? meterType = null,
    Object? powerStation = null,
    Object? name = null,
    Object? code = null,
    Object? description = null,
  }) {
    return _then(_$MeterResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      meterType: null == meterType
          ? _value.meterType
          : meterType // ignore: cast_nullable_to_non_nullable
              as MeterTypeResponse,
      powerStation: null == powerStation
          ? _value.powerStation
          : powerStation // ignore: cast_nullable_to_non_nullable
              as PowerStationResponse,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MeterResponseImpl implements _MeterResponse {
  const _$MeterResponseImpl(
      {this.id = 0,
      this.status = 0,
      this.meterType = const MeterTypeResponse(),
      this.powerStation = const PowerStationResponse(),
      this.name = '',
      this.code = '',
      this.description = ''});

  factory _$MeterResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MeterResponseImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final int status;
  @override
  @JsonKey()
  final MeterTypeResponse meterType;
  @override
  @JsonKey()
  final PowerStationResponse powerStation;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String code;
  @override
  @JsonKey()
  final String description;

  @override
  String toString() {
    return 'MeterResponse(id: $id, status: $status, meterType: $meterType, powerStation: $powerStation, name: $name, code: $code, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeterResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.meterType, meterType) ||
                other.meterType == meterType) &&
            (identical(other.powerStation, powerStation) ||
                other.powerStation == powerStation) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, status, meterType,
      powerStation, name, code, description);

  /// Create a copy of MeterResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MeterResponseImplCopyWith<_$MeterResponseImpl> get copyWith =>
      __$$MeterResponseImplCopyWithImpl<_$MeterResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MeterResponseImplToJson(
      this,
    );
  }
}

abstract class _MeterResponse implements MeterResponse {
  const factory _MeterResponse(
      {final int id,
      final int status,
      final MeterTypeResponse meterType,
      final PowerStationResponse powerStation,
      final String name,
      final String code,
      final String description}) = _$MeterResponseImpl;

  factory _MeterResponse.fromJson(Map<String, dynamic> json) =
      _$MeterResponseImpl.fromJson;

  @override
  int get id;
  @override
  int get status;
  @override
  MeterTypeResponse get meterType;
  @override
  PowerStationResponse get powerStation;
  @override
  String get name;
  @override
  String get code;
  @override
  String get description;

  /// Create a copy of MeterResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MeterResponseImplCopyWith<_$MeterResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
