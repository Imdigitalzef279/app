// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DeviceResponse _$DeviceResponseFromJson(Map<String, dynamic> json) {
  return _DeviceResponse.fromJson(json);
}

/// @nodoc
mixin _$DeviceResponse {
  int get meterTypeId => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  int get projectId => throw _privateConstructorUsedError;
  int get powerStationId => throw _privateConstructorUsedError;
  int get status => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get serialNumber => throw _privateConstructorUsedError;
  String get creator => throw _privateConstructorUsedError;
  String get creationTime => throw _privateConstructorUsedError;
  MeterTypeResponse get meterType => throw _privateConstructorUsedError;
  PowerStationResponse get powerStation => throw _privateConstructorUsedError;

  /// Serializes this DeviceResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeviceResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeviceResponseCopyWith<DeviceResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceResponseCopyWith<$Res> {
  factory $DeviceResponseCopyWith(
          DeviceResponse value, $Res Function(DeviceResponse) then) =
      _$DeviceResponseCopyWithImpl<$Res, DeviceResponse>;
  @useResult
  $Res call(
      {int meterTypeId,
      int id,
      int projectId,
      int powerStationId,
      int status,
      String name,
      String code,
      String description,
      String serialNumber,
      String creator,
      String creationTime,
      MeterTypeResponse meterType,
      PowerStationResponse powerStation});

  $MeterTypeResponseCopyWith<$Res> get meterType;
  $PowerStationResponseCopyWith<$Res> get powerStation;
}

/// @nodoc
class _$DeviceResponseCopyWithImpl<$Res, $Val extends DeviceResponse>
    implements $DeviceResponseCopyWith<$Res> {
  _$DeviceResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeviceResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meterTypeId = null,
    Object? id = null,
    Object? projectId = null,
    Object? powerStationId = null,
    Object? status = null,
    Object? name = null,
    Object? code = null,
    Object? description = null,
    Object? serialNumber = null,
    Object? creator = null,
    Object? creationTime = null,
    Object? meterType = null,
    Object? powerStation = null,
  }) {
    return _then(_value.copyWith(
      meterTypeId: null == meterTypeId
          ? _value.meterTypeId
          : meterTypeId // ignore: cast_nullable_to_non_nullable
              as int,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as int,
      powerStationId: null == powerStationId
          ? _value.powerStationId
          : powerStationId // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
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
      serialNumber: null == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String,
      creator: null == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as String,
      creationTime: null == creationTime
          ? _value.creationTime
          : creationTime // ignore: cast_nullable_to_non_nullable
              as String,
      meterType: null == meterType
          ? _value.meterType
          : meterType // ignore: cast_nullable_to_non_nullable
              as MeterTypeResponse,
      powerStation: null == powerStation
          ? _value.powerStation
          : powerStation // ignore: cast_nullable_to_non_nullable
              as PowerStationResponse,
    ) as $Val);
  }

  /// Create a copy of DeviceResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MeterTypeResponseCopyWith<$Res> get meterType {
    return $MeterTypeResponseCopyWith<$Res>(_value.meterType, (value) {
      return _then(_value.copyWith(meterType: value) as $Val);
    });
  }

  /// Create a copy of DeviceResponse
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
abstract class _$$DeviceResponseImplCopyWith<$Res>
    implements $DeviceResponseCopyWith<$Res> {
  factory _$$DeviceResponseImplCopyWith(_$DeviceResponseImpl value,
          $Res Function(_$DeviceResponseImpl) then) =
      __$$DeviceResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int meterTypeId,
      int id,
      int projectId,
      int powerStationId,
      int status,
      String name,
      String code,
      String description,
      String serialNumber,
      String creator,
      String creationTime,
      MeterTypeResponse meterType,
      PowerStationResponse powerStation});

  @override
  $MeterTypeResponseCopyWith<$Res> get meterType;
  @override
  $PowerStationResponseCopyWith<$Res> get powerStation;
}

/// @nodoc
class __$$DeviceResponseImplCopyWithImpl<$Res>
    extends _$DeviceResponseCopyWithImpl<$Res, _$DeviceResponseImpl>
    implements _$$DeviceResponseImplCopyWith<$Res> {
  __$$DeviceResponseImplCopyWithImpl(
      _$DeviceResponseImpl _value, $Res Function(_$DeviceResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeviceResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meterTypeId = null,
    Object? id = null,
    Object? projectId = null,
    Object? powerStationId = null,
    Object? status = null,
    Object? name = null,
    Object? code = null,
    Object? description = null,
    Object? serialNumber = null,
    Object? creator = null,
    Object? creationTime = null,
    Object? meterType = null,
    Object? powerStation = null,
  }) {
    return _then(_$DeviceResponseImpl(
      meterTypeId: null == meterTypeId
          ? _value.meterTypeId
          : meterTypeId // ignore: cast_nullable_to_non_nullable
              as int,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as int,
      powerStationId: null == powerStationId
          ? _value.powerStationId
          : powerStationId // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
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
      serialNumber: null == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String,
      creator: null == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as String,
      creationTime: null == creationTime
          ? _value.creationTime
          : creationTime // ignore: cast_nullable_to_non_nullable
              as String,
      meterType: null == meterType
          ? _value.meterType
          : meterType // ignore: cast_nullable_to_non_nullable
              as MeterTypeResponse,
      powerStation: null == powerStation
          ? _value.powerStation
          : powerStation // ignore: cast_nullable_to_non_nullable
              as PowerStationResponse,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeviceResponseImpl implements _DeviceResponse {
  const _$DeviceResponseImpl(
      {this.meterTypeId = 0,
      this.id = 0,
      this.projectId = 0,
      this.powerStationId = 0,
      this.status = 0,
      this.name = '',
      this.code = '',
      this.description = '',
      this.serialNumber = '',
      this.creator = '',
      this.creationTime = "",
      this.meterType = const MeterTypeResponse(),
      this.powerStation = const PowerStationResponse()});

  factory _$DeviceResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceResponseImplFromJson(json);

  @override
  @JsonKey()
  final int meterTypeId;
  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final int projectId;
  @override
  @JsonKey()
  final int powerStationId;
  @override
  @JsonKey()
  final int status;
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
  final String serialNumber;
  @override
  @JsonKey()
  final String creator;
  @override
  @JsonKey()
  final String creationTime;
  @override
  @JsonKey()
  final MeterTypeResponse meterType;
  @override
  @JsonKey()
  final PowerStationResponse powerStation;

  @override
  String toString() {
    return 'DeviceResponse(meterTypeId: $meterTypeId, id: $id, projectId: $projectId, powerStationId: $powerStationId, status: $status, name: $name, code: $code, description: $description, serialNumber: $serialNumber, creator: $creator, creationTime: $creationTime, meterType: $meterType, powerStation: $powerStation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceResponseImpl &&
            (identical(other.meterTypeId, meterTypeId) ||
                other.meterTypeId == meterTypeId) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.powerStationId, powerStationId) ||
                other.powerStationId == powerStationId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.creator, creator) || other.creator == creator) &&
            (identical(other.creationTime, creationTime) ||
                other.creationTime == creationTime) &&
            (identical(other.meterType, meterType) ||
                other.meterType == meterType) &&
            (identical(other.powerStation, powerStation) ||
                other.powerStation == powerStation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      meterTypeId,
      id,
      projectId,
      powerStationId,
      status,
      name,
      code,
      description,
      serialNumber,
      creator,
      creationTime,
      meterType,
      powerStation);

  /// Create a copy of DeviceResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceResponseImplCopyWith<_$DeviceResponseImpl> get copyWith =>
      __$$DeviceResponseImplCopyWithImpl<_$DeviceResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceResponseImplToJson(
      this,
    );
  }
}

abstract class _DeviceResponse implements DeviceResponse {
  const factory _DeviceResponse(
      {final int meterTypeId,
      final int id,
      final int projectId,
      final int powerStationId,
      final int status,
      final String name,
      final String code,
      final String description,
      final String serialNumber,
      final String creator,
      final String creationTime,
      final MeterTypeResponse meterType,
      final PowerStationResponse powerStation}) = _$DeviceResponseImpl;

  factory _DeviceResponse.fromJson(Map<String, dynamic> json) =
      _$DeviceResponseImpl.fromJson;

  @override
  int get meterTypeId;
  @override
  int get id;
  @override
  int get projectId;
  @override
  int get powerStationId;
  @override
  int get status;
  @override
  String get name;
  @override
  String get code;
  @override
  String get description;
  @override
  String get serialNumber;
  @override
  String get creator;
  @override
  String get creationTime;
  @override
  MeterTypeResponse get meterType;
  @override
  PowerStationResponse get powerStation;

  /// Create a copy of DeviceResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeviceResponseImplCopyWith<_$DeviceResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
