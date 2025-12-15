// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cbs_meter_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CbsMeterRequest _$CbsMeterRequestFromJson(Map<String, dynamic> json) {
  return _CbsMeterRequest.fromJson(json);
}

/// @nodoc
mixin _$CbsMeterRequest {
  int get stationId => throw _privateConstructorUsedError;
  int get typeId => throw _privateConstructorUsedError;
  String get apiKey => throw _privateConstructorUsedError;
  List<CbsItem> get cbsList => throw _privateConstructorUsedError;

  /// Serializes this CbsMeterRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CbsMeterRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CbsMeterRequestCopyWith<CbsMeterRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CbsMeterRequestCopyWith<$Res> {
  factory $CbsMeterRequestCopyWith(
          CbsMeterRequest value, $Res Function(CbsMeterRequest) then) =
      _$CbsMeterRequestCopyWithImpl<$Res, CbsMeterRequest>;
  @useResult
  $Res call({int stationId, int typeId, String apiKey, List<CbsItem> cbsList});
}

/// @nodoc
class _$CbsMeterRequestCopyWithImpl<$Res, $Val extends CbsMeterRequest>
    implements $CbsMeterRequestCopyWith<$Res> {
  _$CbsMeterRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CbsMeterRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stationId = null,
    Object? typeId = null,
    Object? apiKey = null,
    Object? cbsList = null,
  }) {
    return _then(_value.copyWith(
      stationId: null == stationId
          ? _value.stationId
          : stationId // ignore: cast_nullable_to_non_nullable
              as int,
      typeId: null == typeId
          ? _value.typeId
          : typeId // ignore: cast_nullable_to_non_nullable
              as int,
      apiKey: null == apiKey
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String,
      cbsList: null == cbsList
          ? _value.cbsList
          : cbsList // ignore: cast_nullable_to_non_nullable
              as List<CbsItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CbsMeterRequestImplCopyWith<$Res>
    implements $CbsMeterRequestCopyWith<$Res> {
  factory _$$CbsMeterRequestImplCopyWith(_$CbsMeterRequestImpl value,
          $Res Function(_$CbsMeterRequestImpl) then) =
      __$$CbsMeterRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int stationId, int typeId, String apiKey, List<CbsItem> cbsList});
}

/// @nodoc
class __$$CbsMeterRequestImplCopyWithImpl<$Res>
    extends _$CbsMeterRequestCopyWithImpl<$Res, _$CbsMeterRequestImpl>
    implements _$$CbsMeterRequestImplCopyWith<$Res> {
  __$$CbsMeterRequestImplCopyWithImpl(
      _$CbsMeterRequestImpl _value, $Res Function(_$CbsMeterRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of CbsMeterRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stationId = null,
    Object? typeId = null,
    Object? apiKey = null,
    Object? cbsList = null,
  }) {
    return _then(_$CbsMeterRequestImpl(
      stationId: null == stationId
          ? _value.stationId
          : stationId // ignore: cast_nullable_to_non_nullable
              as int,
      typeId: null == typeId
          ? _value.typeId
          : typeId // ignore: cast_nullable_to_non_nullable
              as int,
      apiKey: null == apiKey
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String,
      cbsList: null == cbsList
          ? _value._cbsList
          : cbsList // ignore: cast_nullable_to_non_nullable
              as List<CbsItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CbsMeterRequestImpl implements _CbsMeterRequest {
  const _$CbsMeterRequestImpl(
      {required this.stationId,
      this.typeId = 81,
      this.apiKey = "KRAPOWER_KEY",
      final List<CbsItem> cbsList = const []})
      : _cbsList = cbsList;

  factory _$CbsMeterRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CbsMeterRequestImplFromJson(json);

  @override
  final int stationId;
  @override
  @JsonKey()
  final int typeId;
  @override
  @JsonKey()
  final String apiKey;
  final List<CbsItem> _cbsList;
  @override
  @JsonKey()
  List<CbsItem> get cbsList {
    if (_cbsList is EqualUnmodifiableListView) return _cbsList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cbsList);
  }

  @override
  String toString() {
    return 'CbsMeterRequest(stationId: $stationId, typeId: $typeId, apiKey: $apiKey, cbsList: $cbsList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CbsMeterRequestImpl &&
            (identical(other.stationId, stationId) ||
                other.stationId == stationId) &&
            (identical(other.typeId, typeId) || other.typeId == typeId) &&
            (identical(other.apiKey, apiKey) || other.apiKey == apiKey) &&
            const DeepCollectionEquality().equals(other._cbsList, _cbsList));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, stationId, typeId, apiKey,
      const DeepCollectionEquality().hash(_cbsList));

  /// Create a copy of CbsMeterRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CbsMeterRequestImplCopyWith<_$CbsMeterRequestImpl> get copyWith =>
      __$$CbsMeterRequestImplCopyWithImpl<_$CbsMeterRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CbsMeterRequestImplToJson(
      this,
    );
  }
}

abstract class _CbsMeterRequest implements CbsMeterRequest {
  const factory _CbsMeterRequest(
      {required final int stationId,
      final int typeId,
      final String apiKey,
      final List<CbsItem> cbsList}) = _$CbsMeterRequestImpl;

  factory _CbsMeterRequest.fromJson(Map<String, dynamic> json) =
      _$CbsMeterRequestImpl.fromJson;

  @override
  int get stationId;
  @override
  int get typeId;
  @override
  String get apiKey;
  @override
  List<CbsItem> get cbsList;

  /// Create a copy of CbsMeterRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CbsMeterRequestImplCopyWith<_$CbsMeterRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
