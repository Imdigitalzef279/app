// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meter_config_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MeterConfigResponse _$MeterConfigResponseFromJson(Map<String, dynamic> json) {
  return _MeterConfigResponse.fromJson(json);
}

/// @nodoc
mixin _$MeterConfigResponse {
  int get id => throw _privateConstructorUsedError;
  int get meterId => throw _privateConstructorUsedError;
  String get configKey => throw _privateConstructorUsedError;
  String get configValue => throw _privateConstructorUsedError;

  /// Serializes this MeterConfigResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MeterConfigResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MeterConfigResponseCopyWith<MeterConfigResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeterConfigResponseCopyWith<$Res> {
  factory $MeterConfigResponseCopyWith(
          MeterConfigResponse value, $Res Function(MeterConfigResponse) then) =
      _$MeterConfigResponseCopyWithImpl<$Res, MeterConfigResponse>;
  @useResult
  $Res call({int id, int meterId, String configKey, String configValue});
}

/// @nodoc
class _$MeterConfigResponseCopyWithImpl<$Res, $Val extends MeterConfigResponse>
    implements $MeterConfigResponseCopyWith<$Res> {
  _$MeterConfigResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MeterConfigResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? meterId = null,
    Object? configKey = null,
    Object? configValue = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      meterId: null == meterId
          ? _value.meterId
          : meterId // ignore: cast_nullable_to_non_nullable
              as int,
      configKey: null == configKey
          ? _value.configKey
          : configKey // ignore: cast_nullable_to_non_nullable
              as String,
      configValue: null == configValue
          ? _value.configValue
          : configValue // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MeterConfigResponseImplCopyWith<$Res>
    implements $MeterConfigResponseCopyWith<$Res> {
  factory _$$MeterConfigResponseImplCopyWith(_$MeterConfigResponseImpl value,
          $Res Function(_$MeterConfigResponseImpl) then) =
      __$$MeterConfigResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int meterId, String configKey, String configValue});
}

/// @nodoc
class __$$MeterConfigResponseImplCopyWithImpl<$Res>
    extends _$MeterConfigResponseCopyWithImpl<$Res, _$MeterConfigResponseImpl>
    implements _$$MeterConfigResponseImplCopyWith<$Res> {
  __$$MeterConfigResponseImplCopyWithImpl(_$MeterConfigResponseImpl _value,
      $Res Function(_$MeterConfigResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of MeterConfigResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? meterId = null,
    Object? configKey = null,
    Object? configValue = null,
  }) {
    return _then(_$MeterConfigResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      meterId: null == meterId
          ? _value.meterId
          : meterId // ignore: cast_nullable_to_non_nullable
              as int,
      configKey: null == configKey
          ? _value.configKey
          : configKey // ignore: cast_nullable_to_non_nullable
              as String,
      configValue: null == configValue
          ? _value.configValue
          : configValue // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MeterConfigResponseImpl implements _MeterConfigResponse {
  const _$MeterConfigResponseImpl(
      {this.id = 0,
      this.meterId = 0,
      this.configKey = '',
      this.configValue = ''});

  factory _$MeterConfigResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MeterConfigResponseImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final int meterId;
  @override
  @JsonKey()
  final String configKey;
  @override
  @JsonKey()
  final String configValue;

  @override
  String toString() {
    return 'MeterConfigResponse(id: $id, meterId: $meterId, configKey: $configKey, configValue: $configValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeterConfigResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.meterId, meterId) || other.meterId == meterId) &&
            (identical(other.configKey, configKey) ||
                other.configKey == configKey) &&
            (identical(other.configValue, configValue) ||
                other.configValue == configValue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, meterId, configKey, configValue);

  /// Create a copy of MeterConfigResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MeterConfigResponseImplCopyWith<_$MeterConfigResponseImpl> get copyWith =>
      __$$MeterConfigResponseImplCopyWithImpl<_$MeterConfigResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MeterConfigResponseImplToJson(
      this,
    );
  }
}

abstract class _MeterConfigResponse implements MeterConfigResponse {
  const factory _MeterConfigResponse(
      {final int id,
      final int meterId,
      final String configKey,
      final String configValue}) = _$MeterConfigResponseImpl;

  factory _MeterConfigResponse.fromJson(Map<String, dynamic> json) =
      _$MeterConfigResponseImpl.fromJson;

  @override
  int get id;
  @override
  int get meterId;
  @override
  String get configKey;
  @override
  String get configValue;

  /// Create a copy of MeterConfigResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MeterConfigResponseImplCopyWith<_$MeterConfigResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
