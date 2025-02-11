// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProjectRequest _$ProjectRequestFromJson(Map<String, dynamic> json) {
  return _ProjectRequest.fromJson(json);
}

/// @nodoc
mixin _$ProjectRequest {
  String get sorting => throw _privateConstructorUsedError;
  int get skipCount => throw _privateConstructorUsedError;
  int get maxResultCount => throw _privateConstructorUsedError;

  /// Serializes this ProjectRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProjectRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProjectRequestCopyWith<ProjectRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectRequestCopyWith<$Res> {
  factory $ProjectRequestCopyWith(
          ProjectRequest value, $Res Function(ProjectRequest) then) =
      _$ProjectRequestCopyWithImpl<$Res, ProjectRequest>;
  @useResult
  $Res call({String sorting, int skipCount, int maxResultCount});
}

/// @nodoc
class _$ProjectRequestCopyWithImpl<$Res, $Val extends ProjectRequest>
    implements $ProjectRequestCopyWith<$Res> {
  _$ProjectRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProjectRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sorting = null,
    Object? skipCount = null,
    Object? maxResultCount = null,
  }) {
    return _then(_value.copyWith(
      sorting: null == sorting
          ? _value.sorting
          : sorting // ignore: cast_nullable_to_non_nullable
              as String,
      skipCount: null == skipCount
          ? _value.skipCount
          : skipCount // ignore: cast_nullable_to_non_nullable
              as int,
      maxResultCount: null == maxResultCount
          ? _value.maxResultCount
          : maxResultCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectRequestImplCopyWith<$Res>
    implements $ProjectRequestCopyWith<$Res> {
  factory _$$ProjectRequestImplCopyWith(_$ProjectRequestImpl value,
          $Res Function(_$ProjectRequestImpl) then) =
      __$$ProjectRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String sorting, int skipCount, int maxResultCount});
}

/// @nodoc
class __$$ProjectRequestImplCopyWithImpl<$Res>
    extends _$ProjectRequestCopyWithImpl<$Res, _$ProjectRequestImpl>
    implements _$$ProjectRequestImplCopyWith<$Res> {
  __$$ProjectRequestImplCopyWithImpl(
      _$ProjectRequestImpl _value, $Res Function(_$ProjectRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProjectRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sorting = null,
    Object? skipCount = null,
    Object? maxResultCount = null,
  }) {
    return _then(_$ProjectRequestImpl(
      sorting: null == sorting
          ? _value.sorting
          : sorting // ignore: cast_nullable_to_non_nullable
              as String,
      skipCount: null == skipCount
          ? _value.skipCount
          : skipCount // ignore: cast_nullable_to_non_nullable
              as int,
      maxResultCount: null == maxResultCount
          ? _value.maxResultCount
          : maxResultCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectRequestImpl implements _ProjectRequest {
  const _$ProjectRequestImpl(
      {this.sorting = 'name asc',
      this.skipCount = 0,
      this.maxResultCount = 10});

  factory _$ProjectRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectRequestImplFromJson(json);

  @override
  @JsonKey()
  final String sorting;
  @override
  @JsonKey()
  final int skipCount;
  @override
  @JsonKey()
  final int maxResultCount;

  @override
  String toString() {
    return 'ProjectRequest(sorting: $sorting, skipCount: $skipCount, maxResultCount: $maxResultCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectRequestImpl &&
            (identical(other.sorting, sorting) || other.sorting == sorting) &&
            (identical(other.skipCount, skipCount) ||
                other.skipCount == skipCount) &&
            (identical(other.maxResultCount, maxResultCount) ||
                other.maxResultCount == maxResultCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, sorting, skipCount, maxResultCount);

  /// Create a copy of ProjectRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectRequestImplCopyWith<_$ProjectRequestImpl> get copyWith =>
      __$$ProjectRequestImplCopyWithImpl<_$ProjectRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectRequestImplToJson(
      this,
    );
  }
}

abstract class _ProjectRequest implements ProjectRequest {
  const factory _ProjectRequest(
      {final String sorting,
      final int skipCount,
      final int maxResultCount}) = _$ProjectRequestImpl;

  factory _ProjectRequest.fromJson(Map<String, dynamic> json) =
      _$ProjectRequestImpl.fromJson;

  @override
  String get sorting;
  @override
  int get skipCount;
  @override
  int get maxResultCount;

  /// Create a copy of ProjectRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectRequestImplCopyWith<_$ProjectRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
