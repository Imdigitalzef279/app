// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'extra_properties.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ExtraProperties _$ExtraPropertiesFromJson(Map<String, dynamic> json) {
  return _ExtraProperties.fromJson(json);
}

/// @nodoc
mixin _$ExtraProperties {
  @JsonKey(name: 'ProjectId')
  int get projectId => throw _privateConstructorUsedError;

  /// Serializes this ExtraProperties to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExtraProperties
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExtraPropertiesCopyWith<ExtraProperties> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExtraPropertiesCopyWith<$Res> {
  factory $ExtraPropertiesCopyWith(
          ExtraProperties value, $Res Function(ExtraProperties) then) =
      _$ExtraPropertiesCopyWithImpl<$Res, ExtraProperties>;
  @useResult
  $Res call({@JsonKey(name: 'ProjectId') int projectId});
}

/// @nodoc
class _$ExtraPropertiesCopyWithImpl<$Res, $Val extends ExtraProperties>
    implements $ExtraPropertiesCopyWith<$Res> {
  _$ExtraPropertiesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExtraProperties
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectId = null,
  }) {
    return _then(_value.copyWith(
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExtraPropertiesImplCopyWith<$Res>
    implements $ExtraPropertiesCopyWith<$Res> {
  factory _$$ExtraPropertiesImplCopyWith(_$ExtraPropertiesImpl value,
          $Res Function(_$ExtraPropertiesImpl) then) =
      __$$ExtraPropertiesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'ProjectId') int projectId});
}

/// @nodoc
class __$$ExtraPropertiesImplCopyWithImpl<$Res>
    extends _$ExtraPropertiesCopyWithImpl<$Res, _$ExtraPropertiesImpl>
    implements _$$ExtraPropertiesImplCopyWith<$Res> {
  __$$ExtraPropertiesImplCopyWithImpl(
      _$ExtraPropertiesImpl _value, $Res Function(_$ExtraPropertiesImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExtraProperties
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectId = null,
  }) {
    return _then(_$ExtraPropertiesImpl(
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExtraPropertiesImpl implements _ExtraProperties {
  const _$ExtraPropertiesImpl(
      {@JsonKey(name: 'ProjectId') required this.projectId});

  factory _$ExtraPropertiesImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExtraPropertiesImplFromJson(json);

  @override
  @JsonKey(name: 'ProjectId')
  final int projectId;

  @override
  String toString() {
    return 'ExtraProperties(projectId: $projectId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExtraPropertiesImpl &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, projectId);

  /// Create a copy of ExtraProperties
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExtraPropertiesImplCopyWith<_$ExtraPropertiesImpl> get copyWith =>
      __$$ExtraPropertiesImplCopyWithImpl<_$ExtraPropertiesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExtraPropertiesImplToJson(
      this,
    );
  }
}

abstract class _ExtraProperties implements ExtraProperties {
  const factory _ExtraProperties(
          {@JsonKey(name: 'ProjectId') required final int projectId}) =
      _$ExtraPropertiesImpl;

  factory _ExtraProperties.fromJson(Map<String, dynamic> json) =
      _$ExtraPropertiesImpl.fromJson;

  @override
  @JsonKey(name: 'ProjectId')
  int get projectId;

  /// Create a copy of ExtraProperties
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExtraPropertiesImplCopyWith<_$ExtraPropertiesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
