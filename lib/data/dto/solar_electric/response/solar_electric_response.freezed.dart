// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'solar_electric_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SolarElectricResponse _$SolarElectricResponseFromJson(
    Map<String, dynamic> json) {
  return _SolarElectricResponse.fromJson(json);
}

/// @nodoc
mixin _$SolarElectricResponse {
  double get gridPower => throw _privateConstructorUsedError;
  double get loadPower => throw _privateConstructorUsedError;
  double get productionPower => throw _privateConstructorUsedError;
  double get productionParam => throw _privateConstructorUsedError;
  double get loadParam => throw _privateConstructorUsedError;
  DateTime? get timeUpdated => throw _privateConstructorUsedError;

  /// Serializes this SolarElectricResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SolarElectricResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SolarElectricResponseCopyWith<SolarElectricResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SolarElectricResponseCopyWith<$Res> {
  factory $SolarElectricResponseCopyWith(SolarElectricResponse value,
          $Res Function(SolarElectricResponse) then) =
      _$SolarElectricResponseCopyWithImpl<$Res, SolarElectricResponse>;
  @useResult
  $Res call(
      {double gridPower,
      double loadPower,
      double productionPower,
      double productionParam,
      double loadParam,
      DateTime? timeUpdated});
}

/// @nodoc
class _$SolarElectricResponseCopyWithImpl<$Res,
        $Val extends SolarElectricResponse>
    implements $SolarElectricResponseCopyWith<$Res> {
  _$SolarElectricResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SolarElectricResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gridPower = null,
    Object? loadPower = null,
    Object? productionPower = null,
    Object? productionParam = null,
    Object? loadParam = null,
    Object? timeUpdated = freezed,
  }) {
    return _then(_value.copyWith(
      gridPower: null == gridPower
          ? _value.gridPower
          : gridPower // ignore: cast_nullable_to_non_nullable
              as double,
      loadPower: null == loadPower
          ? _value.loadPower
          : loadPower // ignore: cast_nullable_to_non_nullable
              as double,
      productionPower: null == productionPower
          ? _value.productionPower
          : productionPower // ignore: cast_nullable_to_non_nullable
              as double,
      productionParam: null == productionParam
          ? _value.productionParam
          : productionParam // ignore: cast_nullable_to_non_nullable
              as double,
      loadParam: null == loadParam
          ? _value.loadParam
          : loadParam // ignore: cast_nullable_to_non_nullable
              as double,
      timeUpdated: freezed == timeUpdated
          ? _value.timeUpdated
          : timeUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SolarElectricResponseImplCopyWith<$Res>
    implements $SolarElectricResponseCopyWith<$Res> {
  factory _$$SolarElectricResponseImplCopyWith(
          _$SolarElectricResponseImpl value,
          $Res Function(_$SolarElectricResponseImpl) then) =
      __$$SolarElectricResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double gridPower,
      double loadPower,
      double productionPower,
      double productionParam,
      double loadParam,
      DateTime? timeUpdated});
}

/// @nodoc
class __$$SolarElectricResponseImplCopyWithImpl<$Res>
    extends _$SolarElectricResponseCopyWithImpl<$Res,
        _$SolarElectricResponseImpl>
    implements _$$SolarElectricResponseImplCopyWith<$Res> {
  __$$SolarElectricResponseImplCopyWithImpl(_$SolarElectricResponseImpl _value,
      $Res Function(_$SolarElectricResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of SolarElectricResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gridPower = null,
    Object? loadPower = null,
    Object? productionPower = null,
    Object? productionParam = null,
    Object? loadParam = null,
    Object? timeUpdated = freezed,
  }) {
    return _then(_$SolarElectricResponseImpl(
      gridPower: null == gridPower
          ? _value.gridPower
          : gridPower // ignore: cast_nullable_to_non_nullable
              as double,
      loadPower: null == loadPower
          ? _value.loadPower
          : loadPower // ignore: cast_nullable_to_non_nullable
              as double,
      productionPower: null == productionPower
          ? _value.productionPower
          : productionPower // ignore: cast_nullable_to_non_nullable
              as double,
      productionParam: null == productionParam
          ? _value.productionParam
          : productionParam // ignore: cast_nullable_to_non_nullable
              as double,
      loadParam: null == loadParam
          ? _value.loadParam
          : loadParam // ignore: cast_nullable_to_non_nullable
              as double,
      timeUpdated: freezed == timeUpdated
          ? _value.timeUpdated
          : timeUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SolarElectricResponseImpl implements _SolarElectricResponse {
  const _$SolarElectricResponseImpl(
      {this.gridPower = 0,
      this.loadPower = 0,
      this.productionPower = 0,
      this.productionParam = 0,
      this.loadParam = 0,
      this.timeUpdated});

  factory _$SolarElectricResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SolarElectricResponseImplFromJson(json);

  @override
  @JsonKey()
  final double gridPower;
  @override
  @JsonKey()
  final double loadPower;
  @override
  @JsonKey()
  final double productionPower;
  @override
  @JsonKey()
  final double productionParam;
  @override
  @JsonKey()
  final double loadParam;
  @override
  final DateTime? timeUpdated;

  @override
  String toString() {
    return 'SolarElectricResponse(gridPower: $gridPower, loadPower: $loadPower, productionPower: $productionPower, productionParam: $productionParam, loadParam: $loadParam, timeUpdated: $timeUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SolarElectricResponseImpl &&
            (identical(other.gridPower, gridPower) ||
                other.gridPower == gridPower) &&
            (identical(other.loadPower, loadPower) ||
                other.loadPower == loadPower) &&
            (identical(other.productionPower, productionPower) ||
                other.productionPower == productionPower) &&
            (identical(other.productionParam, productionParam) ||
                other.productionParam == productionParam) &&
            (identical(other.loadParam, loadParam) ||
                other.loadParam == loadParam) &&
            (identical(other.timeUpdated, timeUpdated) ||
                other.timeUpdated == timeUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, gridPower, loadPower,
      productionPower, productionParam, loadParam, timeUpdated);

  /// Create a copy of SolarElectricResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SolarElectricResponseImplCopyWith<_$SolarElectricResponseImpl>
      get copyWith => __$$SolarElectricResponseImplCopyWithImpl<
          _$SolarElectricResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SolarElectricResponseImplToJson(
      this,
    );
  }
}

abstract class _SolarElectricResponse implements SolarElectricResponse {
  const factory _SolarElectricResponse(
      {final double gridPower,
      final double loadPower,
      final double productionPower,
      final double productionParam,
      final double loadParam,
      final DateTime? timeUpdated}) = _$SolarElectricResponseImpl;

  factory _SolarElectricResponse.fromJson(Map<String, dynamic> json) =
      _$SolarElectricResponseImpl.fromJson;

  @override
  double get gridPower;
  @override
  double get loadPower;
  @override
  double get productionPower;
  @override
  double get productionParam;
  @override
  double get loadParam;
  @override
  DateTime? get timeUpdated;

  /// Create a copy of SolarElectricResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SolarElectricResponseImplCopyWith<_$SolarElectricResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
