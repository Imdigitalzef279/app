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
  int get id => throw _privateConstructorUsedError;
  int get projectId => throw _privateConstructorUsedError;
  int get status => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get serialNumber => throw _privateConstructorUsedError;
  String get creator => throw _privateConstructorUsedError;
  bool get isWarningStatus => throw _privateConstructorUsedError;
  MeterTypeResponse get meterType => throw _privateConstructorUsedError;
  PowerStationResponse get powerStation => throw _privateConstructorUsedError;
  LastedLogDataResponse get lastedLogData => throw _privateConstructorUsedError;

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
      {int id,
      int projectId,
      int status,
      String name,
      String code,
      String description,
      String serialNumber,
      String creator,
      bool isWarningStatus,
      MeterTypeResponse meterType,
      PowerStationResponse powerStation,
      LastedLogDataResponse lastedLogData});

  $MeterTypeResponseCopyWith<$Res> get meterType;
  $PowerStationResponseCopyWith<$Res> get powerStation;
  $LastedLogDataResponseCopyWith<$Res> get lastedLogData;
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
    Object? id = null,
    Object? projectId = null,
    Object? status = null,
    Object? name = null,
    Object? code = null,
    Object? description = null,
    Object? serialNumber = null,
    Object? creator = null,
    Object? isWarningStatus = null,
    Object? meterType = null,
    Object? powerStation = null,
    Object? lastedLogData = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
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
      isWarningStatus: null == isWarningStatus
          ? _value.isWarningStatus
          : isWarningStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      meterType: null == meterType
          ? _value.meterType
          : meterType // ignore: cast_nullable_to_non_nullable
              as MeterTypeResponse,
      powerStation: null == powerStation
          ? _value.powerStation
          : powerStation // ignore: cast_nullable_to_non_nullable
              as PowerStationResponse,
      lastedLogData: null == lastedLogData
          ? _value.lastedLogData
          : lastedLogData // ignore: cast_nullable_to_non_nullable
              as LastedLogDataResponse,
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

  /// Create a copy of DeviceResponse
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
abstract class _$$DeviceResponseImplCopyWith<$Res>
    implements $DeviceResponseCopyWith<$Res> {
  factory _$$DeviceResponseImplCopyWith(_$DeviceResponseImpl value,
          $Res Function(_$DeviceResponseImpl) then) =
      __$$DeviceResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int projectId,
      int status,
      String name,
      String code,
      String description,
      String serialNumber,
      String creator,
      bool isWarningStatus,
      MeterTypeResponse meterType,
      PowerStationResponse powerStation,
      LastedLogDataResponse lastedLogData});

  @override
  $MeterTypeResponseCopyWith<$Res> get meterType;
  @override
  $PowerStationResponseCopyWith<$Res> get powerStation;
  @override
  $LastedLogDataResponseCopyWith<$Res> get lastedLogData;
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
    Object? id = null,
    Object? projectId = null,
    Object? status = null,
    Object? name = null,
    Object? code = null,
    Object? description = null,
    Object? serialNumber = null,
    Object? creator = null,
    Object? isWarningStatus = null,
    Object? meterType = null,
    Object? powerStation = null,
    Object? lastedLogData = null,
  }) {
    return _then(_$DeviceResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
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
      isWarningStatus: null == isWarningStatus
          ? _value.isWarningStatus
          : isWarningStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      meterType: null == meterType
          ? _value.meterType
          : meterType // ignore: cast_nullable_to_non_nullable
              as MeterTypeResponse,
      powerStation: null == powerStation
          ? _value.powerStation
          : powerStation // ignore: cast_nullable_to_non_nullable
              as PowerStationResponse,
      lastedLogData: null == lastedLogData
          ? _value.lastedLogData
          : lastedLogData // ignore: cast_nullable_to_non_nullable
              as LastedLogDataResponse,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeviceResponseImpl implements _DeviceResponse {
  const _$DeviceResponseImpl(
      {this.id = 0,
      this.projectId = 0,
      this.status = 0,
      this.name = '',
      this.code = '',
      this.description = '',
      this.serialNumber = '',
      this.creator = '',
      this.isWarningStatus = false,
      this.meterType = const MeterTypeResponse(),
      this.powerStation = const PowerStationResponse(),
      this.lastedLogData = const LastedLogDataResponse()});

  factory _$DeviceResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceResponseImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final int projectId;
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
  final bool isWarningStatus;
  @override
  @JsonKey()
  final MeterTypeResponse meterType;
  @override
  @JsonKey()
  final PowerStationResponse powerStation;
  @override
  @JsonKey()
  final LastedLogDataResponse lastedLogData;

  @override
  String toString() {
    return 'DeviceResponse(id: $id, projectId: $projectId, status: $status, name: $name, code: $code, description: $description, serialNumber: $serialNumber, creator: $creator, isWarningStatus: $isWarningStatus, meterType: $meterType, powerStation: $powerStation, lastedLogData: $lastedLogData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.creator, creator) || other.creator == creator) &&
            (identical(other.isWarningStatus, isWarningStatus) ||
                other.isWarningStatus == isWarningStatus) &&
            (identical(other.meterType, meterType) ||
                other.meterType == meterType) &&
            (identical(other.powerStation, powerStation) ||
                other.powerStation == powerStation) &&
            (identical(other.lastedLogData, lastedLogData) ||
                other.lastedLogData == lastedLogData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      projectId,
      status,
      name,
      code,
      description,
      serialNumber,
      creator,
      isWarningStatus,
      meterType,
      powerStation,
      lastedLogData);

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
      {final int id,
      final int projectId,
      final int status,
      final String name,
      final String code,
      final String description,
      final String serialNumber,
      final String creator,
      final bool isWarningStatus,
      final MeterTypeResponse meterType,
      final PowerStationResponse powerStation,
      final LastedLogDataResponse lastedLogData}) = _$DeviceResponseImpl;

  factory _DeviceResponse.fromJson(Map<String, dynamic> json) =
      _$DeviceResponseImpl.fromJson;

  @override
  int get id;
  @override
  int get projectId;
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
  bool get isWarningStatus;
  @override
  MeterTypeResponse get meterType;
  @override
  PowerStationResponse get powerStation;
  @override
  LastedLogDataResponse get lastedLogData;

  /// Create a copy of DeviceResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeviceResponseImplCopyWith<_$DeviceResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
