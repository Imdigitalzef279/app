// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProjectResponse _$ProjectResponseFromJson(Map<String, dynamic> json) {
  return __$ProjectResponse.fromJson(json);
}

/// @nodoc
mixin _$ProjectResponse {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get info => throw _privateConstructorUsedError;
  String get creator => throw _privateConstructorUsedError;
  DateTime? get creationTime => throw _privateConstructorUsedError;
  String get lastModifier => throw _privateConstructorUsedError;

  /// Serializes this ProjectResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProjectResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProjectResponseCopyWith<ProjectResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectResponseCopyWith<$Res> {
  factory $ProjectResponseCopyWith(
          ProjectResponse value, $Res Function(ProjectResponse) then) =
      _$ProjectResponseCopyWithImpl<$Res, ProjectResponse>;
  @useResult
  $Res call(
      {int id,
      String name,
      String info,
      String creator,
      DateTime? creationTime,
      String lastModifier});
}

/// @nodoc
class _$ProjectResponseCopyWithImpl<$Res, $Val extends ProjectResponse>
    implements $ProjectResponseCopyWith<$Res> {
  _$ProjectResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProjectResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? info = null,
    Object? creator = null,
    Object? creationTime = freezed,
    Object? lastModifier = null,
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
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as String,
      creator: null == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as String,
      creationTime: freezed == creationTime
          ? _value.creationTime
          : creationTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastModifier: null == lastModifier
          ? _value.lastModifier
          : lastModifier // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_$ProjectResponseImplCopyWith<$Res>
    implements $ProjectResponseCopyWith<$Res> {
  factory _$$_$ProjectResponseImplCopyWith(_$_$ProjectResponseImpl value,
          $Res Function(_$_$ProjectResponseImpl) then) =
      __$$_$ProjectResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String info,
      String creator,
      DateTime? creationTime,
      String lastModifier});
}

/// @nodoc
class __$$_$ProjectResponseImplCopyWithImpl<$Res>
    extends _$ProjectResponseCopyWithImpl<$Res, _$_$ProjectResponseImpl>
    implements _$$_$ProjectResponseImplCopyWith<$Res> {
  __$$_$ProjectResponseImplCopyWithImpl(_$_$ProjectResponseImpl _value,
      $Res Function(_$_$ProjectResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProjectResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? info = null,
    Object? creator = null,
    Object? creationTime = freezed,
    Object? lastModifier = null,
  }) {
    return _then(_$_$ProjectResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as String,
      creator: null == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as String,
      creationTime: freezed == creationTime
          ? _value.creationTime
          : creationTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastModifier: null == lastModifier
          ? _value.lastModifier
          : lastModifier // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_$ProjectResponseImpl implements __$ProjectResponse {
  const _$_$ProjectResponseImpl(
      {this.id = 0,
      this.name = "",
      this.info = "",
      this.creator = "",
      this.creationTime,
      this.lastModifier = ""});

  factory _$_$ProjectResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$_$ProjectResponseImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String info;
  @override
  @JsonKey()
  final String creator;
  @override
  final DateTime? creationTime;
  @override
  @JsonKey()
  final String lastModifier;

  @override
  String toString() {
    return 'ProjectResponse(id: $id, name: $name, info: $info, creator: $creator, creationTime: $creationTime, lastModifier: $lastModifier)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_$ProjectResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.info, info) || other.info == info) &&
            (identical(other.creator, creator) || other.creator == creator) &&
            (identical(other.creationTime, creationTime) ||
                other.creationTime == creationTime) &&
            (identical(other.lastModifier, lastModifier) ||
                other.lastModifier == lastModifier));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, info, creator, creationTime, lastModifier);

  /// Create a copy of ProjectResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$_$ProjectResponseImplCopyWith<_$_$ProjectResponseImpl> get copyWith =>
      __$$_$ProjectResponseImplCopyWithImpl<_$_$ProjectResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_$ProjectResponseImplToJson(
      this,
    );
  }
}

abstract class __$ProjectResponse implements ProjectResponse {
  const factory __$ProjectResponse(
      {final int id,
      final String name,
      final String info,
      final String creator,
      final DateTime? creationTime,
      final String lastModifier}) = _$_$ProjectResponseImpl;

  factory __$ProjectResponse.fromJson(Map<String, dynamic> json) =
      _$_$ProjectResponseImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get info;
  @override
  String get creator;
  @override
  DateTime? get creationTime;
  @override
  String get lastModifier;

  /// Create a copy of ProjectResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$_$ProjectResponseImplCopyWith<_$_$ProjectResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
