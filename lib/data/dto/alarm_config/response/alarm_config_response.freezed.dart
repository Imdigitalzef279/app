// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alarm_config_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AlarmConfigResponse _$AlarmConfigResponseFromJson(Map<String, dynamic> json) {
  return _AlarmConfigResponse.fromJson(json);
}

/// @nodoc
mixin _$AlarmConfigResponse {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  ///  QUAN TRỌNG
  String get logParam => throw _privateConstructorUsedError;
  String get queryType => throw _privateConstructorUsedError;
  String get queryCondition => throw _privateConstructorUsedError;

  /// Serializes this AlarmConfigResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AlarmConfigResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AlarmConfigResponseCopyWith<AlarmConfigResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlarmConfigResponseCopyWith<$Res> {
  factory $AlarmConfigResponseCopyWith(
          AlarmConfigResponse value, $Res Function(AlarmConfigResponse) then) =
      _$AlarmConfigResponseCopyWithImpl<$Res, AlarmConfigResponse>;
  @useResult
  $Res call(
      {int id,
      String name,
      String description,
      String logParam,
      String queryType,
      String queryCondition});
}

/// @nodoc
class _$AlarmConfigResponseCopyWithImpl<$Res, $Val extends AlarmConfigResponse>
    implements $AlarmConfigResponseCopyWith<$Res> {
  _$AlarmConfigResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AlarmConfigResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? logParam = null,
    Object? queryType = null,
    Object? queryCondition = null,
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      logParam: null == logParam
          ? _value.logParam
          : logParam // ignore: cast_nullable_to_non_nullable
              as String,
      queryType: null == queryType
          ? _value.queryType
          : queryType // ignore: cast_nullable_to_non_nullable
              as String,
      queryCondition: null == queryCondition
          ? _value.queryCondition
          : queryCondition // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AlarmConfigResponseImplCopyWith<$Res>
    implements $AlarmConfigResponseCopyWith<$Res> {
  factory _$$AlarmConfigResponseImplCopyWith(_$AlarmConfigResponseImpl value,
          $Res Function(_$AlarmConfigResponseImpl) then) =
      __$$AlarmConfigResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String description,
      String logParam,
      String queryType,
      String queryCondition});
}

/// @nodoc
class __$$AlarmConfigResponseImplCopyWithImpl<$Res>
    extends _$AlarmConfigResponseCopyWithImpl<$Res, _$AlarmConfigResponseImpl>
    implements _$$AlarmConfigResponseImplCopyWith<$Res> {
  __$$AlarmConfigResponseImplCopyWithImpl(_$AlarmConfigResponseImpl _value,
      $Res Function(_$AlarmConfigResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AlarmConfigResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? logParam = null,
    Object? queryType = null,
    Object? queryCondition = null,
  }) {
    return _then(_$AlarmConfigResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      logParam: null == logParam
          ? _value.logParam
          : logParam // ignore: cast_nullable_to_non_nullable
              as String,
      queryType: null == queryType
          ? _value.queryType
          : queryType // ignore: cast_nullable_to_non_nullable
              as String,
      queryCondition: null == queryCondition
          ? _value.queryCondition
          : queryCondition // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AlarmConfigResponseImpl implements _AlarmConfigResponse {
  const _$AlarmConfigResponseImpl(
      {this.id = 0,
      this.name = '',
      this.description = '',
      this.logParam = '',
      this.queryType = '',
      this.queryCondition = ''});

  factory _$AlarmConfigResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlarmConfigResponseImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String description;

  ///  QUAN TRỌNG
  @override
  @JsonKey()
  final String logParam;
  @override
  @JsonKey()
  final String queryType;
  @override
  @JsonKey()
  final String queryCondition;

  @override
  String toString() {
    return 'AlarmConfigResponse(id: $id, name: $name, description: $description, logParam: $logParam, queryType: $queryType, queryCondition: $queryCondition)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlarmConfigResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.logParam, logParam) ||
                other.logParam == logParam) &&
            (identical(other.queryType, queryType) ||
                other.queryType == queryType) &&
            (identical(other.queryCondition, queryCondition) ||
                other.queryCondition == queryCondition));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, description, logParam, queryType, queryCondition);

  /// Create a copy of AlarmConfigResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlarmConfigResponseImplCopyWith<_$AlarmConfigResponseImpl> get copyWith =>
      __$$AlarmConfigResponseImplCopyWithImpl<_$AlarmConfigResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlarmConfigResponseImplToJson(
      this,
    );
  }
}

abstract class _AlarmConfigResponse implements AlarmConfigResponse {
  const factory _AlarmConfigResponse(
      {final int id,
      final String name,
      final String description,
      final String logParam,
      final String queryType,
      final String queryCondition}) = _$AlarmConfigResponseImpl;

  factory _AlarmConfigResponse.fromJson(Map<String, dynamic> json) =
      _$AlarmConfigResponseImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get description;

  ///  QUAN TRỌNG
  @override
  String get logParam;
  @override
  String get queryType;
  @override
  String get queryCondition;

  /// Create a copy of AlarmConfigResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlarmConfigResponseImplCopyWith<_$AlarmConfigResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
