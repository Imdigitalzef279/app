// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meter_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MeterRequest _$MeterRequestFromJson(Map<String, dynamic> json) {
  return _MeterRequest.fromJson(json);
}

/// @nodoc
mixin _$MeterRequest {
  int get id => throw _privateConstructorUsedError;
  int get meterTypeId => throw _privateConstructorUsedError;
  int get powerStationId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get gatewayNumber => throw _privateConstructorUsedError;
  String get serialNumber => throw _privateConstructorUsedError;

  /// Serializes this MeterRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MeterRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MeterRequestCopyWith<MeterRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeterRequestCopyWith<$Res> {
  factory $MeterRequestCopyWith(
          MeterRequest value, $Res Function(MeterRequest) then) =
      _$MeterRequestCopyWithImpl<$Res, MeterRequest>;
  @useResult
  $Res call(
      {int id,
      int meterTypeId,
      int powerStationId,
      String name,
      String code,
      String description,
      String gatewayNumber,
      String serialNumber});
}

/// @nodoc
class _$MeterRequestCopyWithImpl<$Res, $Val extends MeterRequest>
    implements $MeterRequestCopyWith<$Res> {
  _$MeterRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MeterRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? meterTypeId = null,
    Object? powerStationId = null,
    Object? name = null,
    Object? code = null,
    Object? description = null,
    Object? gatewayNumber = null,
    Object? serialNumber = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      meterTypeId: null == meterTypeId
          ? _value.meterTypeId
          : meterTypeId // ignore: cast_nullable_to_non_nullable
              as int,
      powerStationId: null == powerStationId
          ? _value.powerStationId
          : powerStationId // ignore: cast_nullable_to_non_nullable
              as int,
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
      gatewayNumber: null == gatewayNumber
          ? _value.gatewayNumber
          : gatewayNumber // ignore: cast_nullable_to_non_nullable
              as String,
      serialNumber: null == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MeterRequestImplCopyWith<$Res>
    implements $MeterRequestCopyWith<$Res> {
  factory _$$MeterRequestImplCopyWith(
          _$MeterRequestImpl value, $Res Function(_$MeterRequestImpl) then) =
      __$$MeterRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int meterTypeId,
      int powerStationId,
      String name,
      String code,
      String description,
      String gatewayNumber,
      String serialNumber});
}

/// @nodoc
class __$$MeterRequestImplCopyWithImpl<$Res>
    extends _$MeterRequestCopyWithImpl<$Res, _$MeterRequestImpl>
    implements _$$MeterRequestImplCopyWith<$Res> {
  __$$MeterRequestImplCopyWithImpl(
      _$MeterRequestImpl _value, $Res Function(_$MeterRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of MeterRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? meterTypeId = null,
    Object? powerStationId = null,
    Object? name = null,
    Object? code = null,
    Object? description = null,
    Object? gatewayNumber = null,
    Object? serialNumber = null,
  }) {
    return _then(_$MeterRequestImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      meterTypeId: null == meterTypeId
          ? _value.meterTypeId
          : meterTypeId // ignore: cast_nullable_to_non_nullable
              as int,
      powerStationId: null == powerStationId
          ? _value.powerStationId
          : powerStationId // ignore: cast_nullable_to_non_nullable
              as int,
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
      gatewayNumber: null == gatewayNumber
          ? _value.gatewayNumber
          : gatewayNumber // ignore: cast_nullable_to_non_nullable
              as String,
      serialNumber: null == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MeterRequestImpl implements _MeterRequest {
  const _$MeterRequestImpl(
      {this.id = 0,
      this.meterTypeId = 2,
      this.powerStationId = 0,
      this.name = "",
      this.code = "",
      this.description = "",
      this.gatewayNumber = "",
      this.serialNumber = ""});

  factory _$MeterRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$MeterRequestImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final int meterTypeId;
  @override
  @JsonKey()
  final int powerStationId;
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
  @JsonKey()
  final String gatewayNumber;
  @override
  @JsonKey()
  final String serialNumber;

  @override
  String toString() {
    return 'MeterRequest(id: $id, meterTypeId: $meterTypeId, powerStationId: $powerStationId, name: $name, code: $code, description: $description, gatewayNumber: $gatewayNumber, serialNumber: $serialNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeterRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.meterTypeId, meterTypeId) ||
                other.meterTypeId == meterTypeId) &&
            (identical(other.powerStationId, powerStationId) ||
                other.powerStationId == powerStationId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.gatewayNumber, gatewayNumber) ||
                other.gatewayNumber == gatewayNumber) &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, meterTypeId, powerStationId,
      name, code, description, gatewayNumber, serialNumber);

  /// Create a copy of MeterRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MeterRequestImplCopyWith<_$MeterRequestImpl> get copyWith =>
      __$$MeterRequestImplCopyWithImpl<_$MeterRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MeterRequestImplToJson(
      this,
    );
  }
}

abstract class _MeterRequest implements MeterRequest {
  const factory _MeterRequest(
      {final int id,
      final int meterTypeId,
      final int powerStationId,
      final String name,
      final String code,
      final String description,
      final String gatewayNumber,
      final String serialNumber}) = _$MeterRequestImpl;

  factory _MeterRequest.fromJson(Map<String, dynamic> json) =
      _$MeterRequestImpl.fromJson;

  @override
  int get id;
  @override
  int get meterTypeId;
  @override
  int get powerStationId;
  @override
  String get name;
  @override
  String get code;
  @override
  String get description;
  @override
  String get gatewayNumber;
  @override
  String get serialNumber;

  /// Create a copy of MeterRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MeterRequestImplCopyWith<_$MeterRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
