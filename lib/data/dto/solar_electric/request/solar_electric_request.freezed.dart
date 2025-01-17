// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'solar_electric_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SolarElectricRequest _$SolarElectricRequestFromJson(Map<String, dynamic> json) {
  return _SolarElectricRequest.fromJson(json);
}

/// @nodoc
mixin _$SolarElectricRequest {
  int get powerStationId => throw _privateConstructorUsedError;
  SearchType get searchType => throw _privateConstructorUsedError;
  String get searchValue => throw _privateConstructorUsedError;

  /// Serializes this SolarElectricRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SolarElectricRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SolarElectricRequestCopyWith<SolarElectricRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SolarElectricRequestCopyWith<$Res> {
  factory $SolarElectricRequestCopyWith(SolarElectricRequest value,
          $Res Function(SolarElectricRequest) then) =
      _$SolarElectricRequestCopyWithImpl<$Res, SolarElectricRequest>;
  @useResult
  $Res call({int powerStationId, SearchType searchType, String searchValue});
}

/// @nodoc
class _$SolarElectricRequestCopyWithImpl<$Res,
        $Val extends SolarElectricRequest>
    implements $SolarElectricRequestCopyWith<$Res> {
  _$SolarElectricRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SolarElectricRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? powerStationId = null,
    Object? searchType = null,
    Object? searchValue = null,
  }) {
    return _then(_value.copyWith(
      powerStationId: null == powerStationId
          ? _value.powerStationId
          : powerStationId // ignore: cast_nullable_to_non_nullable
              as int,
      searchType: null == searchType
          ? _value.searchType
          : searchType // ignore: cast_nullable_to_non_nullable
              as SearchType,
      searchValue: null == searchValue
          ? _value.searchValue
          : searchValue // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SolarElectricRequestImplCopyWith<$Res>
    implements $SolarElectricRequestCopyWith<$Res> {
  factory _$$SolarElectricRequestImplCopyWith(_$SolarElectricRequestImpl value,
          $Res Function(_$SolarElectricRequestImpl) then) =
      __$$SolarElectricRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int powerStationId, SearchType searchType, String searchValue});
}

/// @nodoc
class __$$SolarElectricRequestImplCopyWithImpl<$Res>
    extends _$SolarElectricRequestCopyWithImpl<$Res, _$SolarElectricRequestImpl>
    implements _$$SolarElectricRequestImplCopyWith<$Res> {
  __$$SolarElectricRequestImplCopyWithImpl(_$SolarElectricRequestImpl _value,
      $Res Function(_$SolarElectricRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of SolarElectricRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? powerStationId = null,
    Object? searchType = null,
    Object? searchValue = null,
  }) {
    return _then(_$SolarElectricRequestImpl(
      powerStationId: null == powerStationId
          ? _value.powerStationId
          : powerStationId // ignore: cast_nullable_to_non_nullable
              as int,
      searchType: null == searchType
          ? _value.searchType
          : searchType // ignore: cast_nullable_to_non_nullable
              as SearchType,
      searchValue: null == searchValue
          ? _value.searchValue
          : searchValue // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SolarElectricRequestImpl implements _SolarElectricRequest {
  const _$SolarElectricRequestImpl(
      {required this.powerStationId,
      required this.searchType,
      required this.searchValue});

  factory _$SolarElectricRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SolarElectricRequestImplFromJson(json);

  @override
  final int powerStationId;
  @override
  final SearchType searchType;
  @override
  final String searchValue;

  @override
  String toString() {
    return 'SolarElectricRequest(powerStationId: $powerStationId, searchType: $searchType, searchValue: $searchValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SolarElectricRequestImpl &&
            (identical(other.powerStationId, powerStationId) ||
                other.powerStationId == powerStationId) &&
            (identical(other.searchType, searchType) ||
                other.searchType == searchType) &&
            (identical(other.searchValue, searchValue) ||
                other.searchValue == searchValue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, powerStationId, searchType, searchValue);

  /// Create a copy of SolarElectricRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SolarElectricRequestImplCopyWith<_$SolarElectricRequestImpl>
      get copyWith =>
          __$$SolarElectricRequestImplCopyWithImpl<_$SolarElectricRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SolarElectricRequestImplToJson(
      this,
    );
  }
}

abstract class _SolarElectricRequest implements SolarElectricRequest {
  const factory _SolarElectricRequest(
      {required final int powerStationId,
      required final SearchType searchType,
      required final String searchValue}) = _$SolarElectricRequestImpl;

  factory _SolarElectricRequest.fromJson(Map<String, dynamic> json) =
      _$SolarElectricRequestImpl.fromJson;

  @override
  int get powerStationId;
  @override
  SearchType get searchType;
  @override
  String get searchValue;

  /// Create a copy of SolarElectricRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SolarElectricRequestImplCopyWith<_$SolarElectricRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
