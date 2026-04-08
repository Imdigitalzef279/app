// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'result_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ResultResponse<T> _$ResultResponseFromJson<T>(
    Map<String, dynamic> json, T Function(Object?) fromJsonT) {
  return _ResultResponse<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$ResultResponse<T> {
  T? get result => throw _privateConstructorUsedError;

  /// Serializes this ResultResponse to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;

  /// Create a copy of ResultResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResultResponseCopyWith<T, ResultResponse<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultResponseCopyWith<T, $Res> {
  factory $ResultResponseCopyWith(
          ResultResponse<T> value, $Res Function(ResultResponse<T>) then) =
      _$ResultResponseCopyWithImpl<T, $Res, ResultResponse<T>>;
  @useResult
  $Res call({T? result});
}

/// @nodoc
class _$ResultResponseCopyWithImpl<T, $Res, $Val extends ResultResponse<T>>
    implements $ResultResponseCopyWith<T, $Res> {
  _$ResultResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResultResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = freezed,
  }) {
    return _then(_value.copyWith(
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as T?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResultResponseImplCopyWith<T, $Res>
    implements $ResultResponseCopyWith<T, $Res> {
  factory _$$ResultResponseImplCopyWith(_$ResultResponseImpl<T> value,
          $Res Function(_$ResultResponseImpl<T>) then) =
      __$$ResultResponseImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({T? result});
}

/// @nodoc
class __$$ResultResponseImplCopyWithImpl<T, $Res>
    extends _$ResultResponseCopyWithImpl<T, $Res, _$ResultResponseImpl<T>>
    implements _$$ResultResponseImplCopyWith<T, $Res> {
  __$$ResultResponseImplCopyWithImpl(_$ResultResponseImpl<T> _value,
      $Res Function(_$ResultResponseImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of ResultResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = freezed,
  }) {
    return _then(_$ResultResponseImpl<T>(
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as T?,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$ResultResponseImpl<T> implements _ResultResponse<T> {
  const _$ResultResponseImpl({this.result});

  factory _$ResultResponseImpl.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$ResultResponseImplFromJson(json, fromJsonT);

  @override
  final T? result;

  @override
  String toString() {
    return 'ResultResponse<$T>(result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResultResponseImpl<T> &&
            const DeepCollectionEquality().equals(other.result, result));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(result));

  /// Create a copy of ResultResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResultResponseImplCopyWith<T, _$ResultResponseImpl<T>> get copyWith =>
      __$$ResultResponseImplCopyWithImpl<T, _$ResultResponseImpl<T>>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$ResultResponseImplToJson<T>(this, toJsonT);
  }
}

abstract class _ResultResponse<T> implements ResultResponse<T> {
  const factory _ResultResponse({final T? result}) = _$ResultResponseImpl<T>;

  factory _ResultResponse.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$ResultResponseImpl<T>.fromJson;

  @override
  T? get result;

  /// Create a copy of ResultResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResultResponseImplCopyWith<T, _$ResultResponseImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
