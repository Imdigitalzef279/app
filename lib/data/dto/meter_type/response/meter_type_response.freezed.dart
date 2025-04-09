// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meter_type_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MeterTypeResponse _$MeterTypeResponseFromJson(Map<String, dynamic> json) {
  return _MeterTypeResponse.fromJson(json);
}

/// @nodoc
mixin _$MeterTypeResponse {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get storeParam => throw _privateConstructorUsedError;
  String get creationTime => throw _privateConstructorUsedError;
  int get status => throw _privateConstructorUsedError;

  /// Serializes this MeterTypeResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MeterTypeResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MeterTypeResponseCopyWith<MeterTypeResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeterTypeResponseCopyWith<$Res> {
  factory $MeterTypeResponseCopyWith(
          MeterTypeResponse value, $Res Function(MeterTypeResponse) then) =
      _$MeterTypeResponseCopyWithImpl<$Res, MeterTypeResponse>;
  @useResult
  $Res call(
      {int id,
      String name,
      String code,
      String storeParam,
      String creationTime,
      int status});
}

/// @nodoc
class _$MeterTypeResponseCopyWithImpl<$Res, $Val extends MeterTypeResponse>
    implements $MeterTypeResponseCopyWith<$Res> {
  _$MeterTypeResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MeterTypeResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? code = null,
    Object? storeParam = null,
    Object? creationTime = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      storeParam: null == storeParam
          ? _value.storeParam
          : storeParam // ignore: cast_nullable_to_non_nullable
              as String,
      creationTime: null == creationTime
          ? _value.creationTime
          : creationTime // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MeterTypeResponseImplCopyWith<$Res>
    implements $MeterTypeResponseCopyWith<$Res> {
  factory _$$MeterTypeResponseImplCopyWith(_$MeterTypeResponseImpl value,
          $Res Function(_$MeterTypeResponseImpl) then) =
      __$$MeterTypeResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String code,
      String storeParam,
      String creationTime,
      int status});
}

/// @nodoc
class __$$MeterTypeResponseImplCopyWithImpl<$Res>
    extends _$MeterTypeResponseCopyWithImpl<$Res, _$MeterTypeResponseImpl>
    implements _$$MeterTypeResponseImplCopyWith<$Res> {
  __$$MeterTypeResponseImplCopyWithImpl(_$MeterTypeResponseImpl _value,
      $Res Function(_$MeterTypeResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of MeterTypeResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? code = null,
    Object? storeParam = null,
    Object? creationTime = null,
    Object? status = null,
  }) {
    return _then(_$MeterTypeResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      storeParam: null == storeParam
          ? _value.storeParam
          : storeParam // ignore: cast_nullable_to_non_nullable
              as String,
      creationTime: null == creationTime
          ? _value.creationTime
          : creationTime // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MeterTypeResponseImpl implements _MeterTypeResponse {
  const _$MeterTypeResponseImpl(
      {this.id = 0,
      this.name = '',
      this.code = '',
      this.storeParam = '',
      this.creationTime = "",
      this.status = 0});

  factory _$MeterTypeResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MeterTypeResponseImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String code;
  @override
  @JsonKey()
  final String storeParam;
  @override
  @JsonKey()
  final String creationTime;
  @override
  @JsonKey()
  final int status;

  @override
  String toString() {
    return 'MeterTypeResponse(id: $id, name: $name, code: $code, storeParam: $storeParam, creationTime: $creationTime, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeterTypeResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.storeParam, storeParam) ||
                other.storeParam == storeParam) &&
            (identical(other.creationTime, creationTime) ||
                other.creationTime == creationTime) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, code, storeParam, creationTime, status);

  /// Create a copy of MeterTypeResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MeterTypeResponseImplCopyWith<_$MeterTypeResponseImpl> get copyWith =>
      __$$MeterTypeResponseImplCopyWithImpl<_$MeterTypeResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MeterTypeResponseImplToJson(
      this,
    );
  }
}

abstract class _MeterTypeResponse implements MeterTypeResponse {
  const factory _MeterTypeResponse(
      {final int id,
      final String name,
      final String code,
      final String storeParam,
      final String creationTime,
      final int status}) = _$MeterTypeResponseImpl;

  factory _MeterTypeResponse.fromJson(Map<String, dynamic> json) =
      _$MeterTypeResponseImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get code;
  @override
  String get storeParam;
  @override
  String get creationTime;
  @override
  int get status;

  /// Create a copy of MeterTypeResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MeterTypeResponseImplCopyWith<_$MeterTypeResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
