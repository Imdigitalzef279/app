// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meter_config_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MeterConfigRequest _$MeterConfigRequestFromJson(Map<String, dynamic> json) {
  return _MeterConfigRequest.fromJson(json);
}

/// @nodoc
mixin _$MeterConfigRequest {
  int get meterId => throw _privateConstructorUsedError;
  String get configKey => throw _privateConstructorUsedError;
  int get configValue => throw _privateConstructorUsedError;

  /// Serializes this MeterConfigRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MeterConfigRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MeterConfigRequestCopyWith<MeterConfigRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeterConfigRequestCopyWith<$Res> {
  factory $MeterConfigRequestCopyWith(
          MeterConfigRequest value, $Res Function(MeterConfigRequest) then) =
      _$MeterConfigRequestCopyWithImpl<$Res, MeterConfigRequest>;
  @useResult
  $Res call({int meterId, String configKey, int configValue});
}

/// @nodoc
class _$MeterConfigRequestCopyWithImpl<$Res, $Val extends MeterConfigRequest>
    implements $MeterConfigRequestCopyWith<$Res> {
  _$MeterConfigRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MeterConfigRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meterId = null,
    Object? configKey = null,
    Object? configValue = null,
  }) {
    return _then(_value.copyWith(
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
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MeterConfigRequestImplCopyWith<$Res>
    implements $MeterConfigRequestCopyWith<$Res> {
  factory _$$MeterConfigRequestImplCopyWith(_$MeterConfigRequestImpl value,
          $Res Function(_$MeterConfigRequestImpl) then) =
      __$$MeterConfigRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int meterId, String configKey, int configValue});
}

/// @nodoc
class __$$MeterConfigRequestImplCopyWithImpl<$Res>
    extends _$MeterConfigRequestCopyWithImpl<$Res, _$MeterConfigRequestImpl>
    implements _$$MeterConfigRequestImplCopyWith<$Res> {
  __$$MeterConfigRequestImplCopyWithImpl(_$MeterConfigRequestImpl _value,
      $Res Function(_$MeterConfigRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of MeterConfigRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meterId = null,
    Object? configKey = null,
    Object? configValue = null,
  }) {
    return _then(_$MeterConfigRequestImpl(
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
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MeterConfigRequestImpl implements _MeterConfigRequest {
  const _$MeterConfigRequestImpl(
      {required this.meterId,
      required this.configKey,
      required this.configValue});

  factory _$MeterConfigRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$MeterConfigRequestImplFromJson(json);

  @override
  final int meterId;
  @override
  final String configKey;
  @override
  final int configValue;

  @override
  String toString() {
    return 'MeterConfigRequest(meterId: $meterId, configKey: $configKey, configValue: $configValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeterConfigRequestImpl &&
            (identical(other.meterId, meterId) || other.meterId == meterId) &&
            (identical(other.configKey, configKey) ||
                other.configKey == configKey) &&
            (identical(other.configValue, configValue) ||
                other.configValue == configValue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, meterId, configKey, configValue);

  /// Create a copy of MeterConfigRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MeterConfigRequestImplCopyWith<_$MeterConfigRequestImpl> get copyWith =>
      __$$MeterConfigRequestImplCopyWithImpl<_$MeterConfigRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MeterConfigRequestImplToJson(
      this,
    );
  }
}

abstract class _MeterConfigRequest implements MeterConfigRequest {
  const factory _MeterConfigRequest(
      {required final int meterId,
      required final String configKey,
      required final int configValue}) = _$MeterConfigRequestImpl;

  factory _MeterConfigRequest.fromJson(Map<String, dynamic> json) =
      _$MeterConfigRequestImpl.fromJson;

  @override
  int get meterId;
  @override
  String get configKey;
  @override
  int get configValue;

  /// Create a copy of MeterConfigRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MeterConfigRequestImplCopyWith<_$MeterConfigRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
