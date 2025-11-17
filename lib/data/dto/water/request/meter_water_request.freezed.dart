// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meter_water_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MeterWaterRequest _$MeterWaterRequestFromJson(Map<String, dynamic> json) {
  return _MeterWaterRequest.fromJson(json);
}

/// @nodoc
mixin _$MeterWaterRequest {
  int get detailId => throw _privateConstructorUsedError;
  int get powerStationId => throw _privateConstructorUsedError;
  String get fromDate => throw _privateConstructorUsedError;
  String get toDate => throw _privateConstructorUsedError;

  /// Serializes this MeterWaterRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MeterWaterRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MeterWaterRequestCopyWith<MeterWaterRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeterWaterRequestCopyWith<$Res> {
  factory $MeterWaterRequestCopyWith(
          MeterWaterRequest value, $Res Function(MeterWaterRequest) then) =
      _$MeterWaterRequestCopyWithImpl<$Res, MeterWaterRequest>;
  @useResult
  $Res call({int detailId, int powerStationId, String fromDate, String toDate});
}

/// @nodoc
class _$MeterWaterRequestCopyWithImpl<$Res, $Val extends MeterWaterRequest>
    implements $MeterWaterRequestCopyWith<$Res> {
  _$MeterWaterRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MeterWaterRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? detailId = null,
    Object? powerStationId = null,
    Object? fromDate = null,
    Object? toDate = null,
  }) {
    return _then(_value.copyWith(
      detailId: null == detailId
          ? _value.detailId
          : detailId // ignore: cast_nullable_to_non_nullable
              as int,
      powerStationId: null == powerStationId
          ? _value.powerStationId
          : powerStationId // ignore: cast_nullable_to_non_nullable
              as int,
      fromDate: null == fromDate
          ? _value.fromDate
          : fromDate // ignore: cast_nullable_to_non_nullable
              as String,
      toDate: null == toDate
          ? _value.toDate
          : toDate // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MeterWaterRequestImplCopyWith<$Res>
    implements $MeterWaterRequestCopyWith<$Res> {
  factory _$$MeterWaterRequestImplCopyWith(_$MeterWaterRequestImpl value,
          $Res Function(_$MeterWaterRequestImpl) then) =
      __$$MeterWaterRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int detailId, int powerStationId, String fromDate, String toDate});
}

/// @nodoc
class __$$MeterWaterRequestImplCopyWithImpl<$Res>
    extends _$MeterWaterRequestCopyWithImpl<$Res, _$MeterWaterRequestImpl>
    implements _$$MeterWaterRequestImplCopyWith<$Res> {
  __$$MeterWaterRequestImplCopyWithImpl(_$MeterWaterRequestImpl _value,
      $Res Function(_$MeterWaterRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of MeterWaterRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? detailId = null,
    Object? powerStationId = null,
    Object? fromDate = null,
    Object? toDate = null,
  }) {
    return _then(_$MeterWaterRequestImpl(
      detailId: null == detailId
          ? _value.detailId
          : detailId // ignore: cast_nullable_to_non_nullable
              as int,
      powerStationId: null == powerStationId
          ? _value.powerStationId
          : powerStationId // ignore: cast_nullable_to_non_nullable
              as int,
      fromDate: null == fromDate
          ? _value.fromDate
          : fromDate // ignore: cast_nullable_to_non_nullable
              as String,
      toDate: null == toDate
          ? _value.toDate
          : toDate // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MeterWaterRequestImpl implements _MeterWaterRequest {
  const _$MeterWaterRequestImpl(
      {required this.detailId,
      required this.powerStationId,
      required this.fromDate,
      required this.toDate});

  factory _$MeterWaterRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$MeterWaterRequestImplFromJson(json);

  @override
  final int detailId;
  @override
  final int powerStationId;
  @override
  final String fromDate;
  @override
  final String toDate;

  @override
  String toString() {
    return 'MeterWaterRequest(detailId: $detailId, powerStationId: $powerStationId, fromDate: $fromDate, toDate: $toDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeterWaterRequestImpl &&
            (identical(other.detailId, detailId) ||
                other.detailId == detailId) &&
            (identical(other.powerStationId, powerStationId) ||
                other.powerStationId == powerStationId) &&
            (identical(other.fromDate, fromDate) ||
                other.fromDate == fromDate) &&
            (identical(other.toDate, toDate) || other.toDate == toDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, detailId, powerStationId, fromDate, toDate);

  /// Create a copy of MeterWaterRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MeterWaterRequestImplCopyWith<_$MeterWaterRequestImpl> get copyWith =>
      __$$MeterWaterRequestImplCopyWithImpl<_$MeterWaterRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MeterWaterRequestImplToJson(
      this,
    );
  }
}

abstract class _MeterWaterRequest implements MeterWaterRequest {
  const factory _MeterWaterRequest(
      {required final int detailId,
      required final int powerStationId,
      required final String fromDate,
      required final String toDate}) = _$MeterWaterRequestImpl;

  factory _MeterWaterRequest.fromJson(Map<String, dynamic> json) =
      _$MeterWaterRequestImpl.fromJson;

  @override
  int get detailId;
  @override
  int get powerStationId;
  @override
  String get fromDate;
  @override
  String get toDate;

  /// Create a copy of MeterWaterRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MeterWaterRequestImplCopyWith<_$MeterWaterRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
