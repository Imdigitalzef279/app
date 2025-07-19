// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'power_station_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PowerStationRequest _$PowerStationRequestFromJson(Map<String, dynamic> json) {
  return _PowerStationRequest.fromJson(json);
}

/// @nodoc
mixin _$PowerStationRequest {
  int get projectId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get longitude => throw _privateConstructorUsedError;
  String get latitude => throw _privateConstructorUsedError;
  String get planViewPath => throw _privateConstructorUsedError;

  /// Serializes this PowerStationRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PowerStationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PowerStationRequestCopyWith<PowerStationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PowerStationRequestCopyWith<$Res> {
  factory $PowerStationRequestCopyWith(
          PowerStationRequest value, $Res Function(PowerStationRequest) then) =
      _$PowerStationRequestCopyWithImpl<$Res, PowerStationRequest>;
  @useResult
  $Res call(
      {int projectId,
      String name,
      String code,
      String description,
      String longitude,
      String latitude,
      String planViewPath});
}

/// @nodoc
class _$PowerStationRequestCopyWithImpl<$Res, $Val extends PowerStationRequest>
    implements $PowerStationRequestCopyWith<$Res> {
  _$PowerStationRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PowerStationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectId = null,
    Object? name = null,
    Object? code = null,
    Object? description = null,
    Object? longitude = null,
    Object? latitude = null,
    Object? planViewPath = null,
  }) {
    return _then(_value.copyWith(
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
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
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as String,
      planViewPath: null == planViewPath
          ? _value.planViewPath
          : planViewPath // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PowerStationRequestImplCopyWith<$Res>
    implements $PowerStationRequestCopyWith<$Res> {
  factory _$$PowerStationRequestImplCopyWith(_$PowerStationRequestImpl value,
          $Res Function(_$PowerStationRequestImpl) then) =
      __$$PowerStationRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int projectId,
      String name,
      String code,
      String description,
      String longitude,
      String latitude,
      String planViewPath});
}

/// @nodoc
class __$$PowerStationRequestImplCopyWithImpl<$Res>
    extends _$PowerStationRequestCopyWithImpl<$Res, _$PowerStationRequestImpl>
    implements _$$PowerStationRequestImplCopyWith<$Res> {
  __$$PowerStationRequestImplCopyWithImpl(_$PowerStationRequestImpl _value,
      $Res Function(_$PowerStationRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of PowerStationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectId = null,
    Object? name = null,
    Object? code = null,
    Object? description = null,
    Object? longitude = null,
    Object? latitude = null,
    Object? planViewPath = null,
  }) {
    return _then(_$PowerStationRequestImpl(
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
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
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as String,
      planViewPath: null == planViewPath
          ? _value.planViewPath
          : planViewPath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PowerStationRequestImpl implements _PowerStationRequest {
  const _$PowerStationRequestImpl(
      {this.projectId = 0,
      this.name = "",
      this.code = "",
      this.description = "",
      this.longitude = "",
      this.latitude = "",
      this.planViewPath = ""});

  factory _$PowerStationRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PowerStationRequestImplFromJson(json);

  @override
  @JsonKey()
  final int projectId;
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
  final String longitude;
  @override
  @JsonKey()
  final String latitude;
  @override
  @JsonKey()
  final String planViewPath;

  @override
  String toString() {
    return 'PowerStationRequest(projectId: $projectId, name: $name, code: $code, description: $description, longitude: $longitude, latitude: $latitude, planViewPath: $planViewPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PowerStationRequestImpl &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.planViewPath, planViewPath) ||
                other.planViewPath == planViewPath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, projectId, name, code,
      description, longitude, latitude, planViewPath);

  /// Create a copy of PowerStationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PowerStationRequestImplCopyWith<_$PowerStationRequestImpl> get copyWith =>
      __$$PowerStationRequestImplCopyWithImpl<_$PowerStationRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PowerStationRequestImplToJson(
      this,
    );
  }
}

abstract class _PowerStationRequest implements PowerStationRequest {
  const factory _PowerStationRequest(
      {final int projectId,
      final String name,
      final String code,
      final String description,
      final String longitude,
      final String latitude,
      final String planViewPath}) = _$PowerStationRequestImpl;

  factory _PowerStationRequest.fromJson(Map<String, dynamic> json) =
      _$PowerStationRequestImpl.fromJson;

  @override
  int get projectId;
  @override
  String get name;
  @override
  String get code;
  @override
  String get description;
  @override
  String get longitude;
  @override
  String get latitude;
  @override
  String get planViewPath;

  /// Create a copy of PowerStationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PowerStationRequestImplCopyWith<_$PowerStationRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
