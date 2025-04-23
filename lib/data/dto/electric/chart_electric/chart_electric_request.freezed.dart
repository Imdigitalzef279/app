// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chart_electric_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChartElectricRequest _$ChartElectricRequestFromJson(Map<String, dynamic> json) {
  return _ChartElectricRequest.fromJson(json);
}

/// @nodoc
mixin _$ChartElectricRequest {
  @JsonKey(name: 'MeterId')
  int get meterId => throw _privateConstructorUsedError;
  @JsonKey(name: 'Type')
  SearchType get searchType => throw _privateConstructorUsedError;
  @JsonKey(name: 'FromDate')
  String? get fromDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'ToDate')
  String? get toDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'SkipCount')
  int get skipCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'MaxResultCount')
  String get maxResultCount => throw _privateConstructorUsedError;

  /// Serializes this ChartElectricRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChartElectricRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChartElectricRequestCopyWith<ChartElectricRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChartElectricRequestCopyWith<$Res> {
  factory $ChartElectricRequestCopyWith(ChartElectricRequest value,
          $Res Function(ChartElectricRequest) then) =
      _$ChartElectricRequestCopyWithImpl<$Res, ChartElectricRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'MeterId') int meterId,
      @JsonKey(name: 'Type') SearchType searchType,
      @JsonKey(name: 'FromDate') String? fromDate,
      @JsonKey(name: 'ToDate') String? toDate,
      @JsonKey(name: 'SkipCount') int skipCount,
      @JsonKey(name: 'MaxResultCount') String maxResultCount});
}

/// @nodoc
class _$ChartElectricRequestCopyWithImpl<$Res,
        $Val extends ChartElectricRequest>
    implements $ChartElectricRequestCopyWith<$Res> {
  _$ChartElectricRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChartElectricRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meterId = null,
    Object? searchType = null,
    Object? fromDate = freezed,
    Object? toDate = freezed,
    Object? skipCount = null,
    Object? maxResultCount = null,
  }) {
    return _then(_value.copyWith(
      meterId: null == meterId
          ? _value.meterId
          : meterId // ignore: cast_nullable_to_non_nullable
              as int,
      searchType: null == searchType
          ? _value.searchType
          : searchType // ignore: cast_nullable_to_non_nullable
              as SearchType,
      fromDate: freezed == fromDate
          ? _value.fromDate
          : fromDate // ignore: cast_nullable_to_non_nullable
              as String?,
      toDate: freezed == toDate
          ? _value.toDate
          : toDate // ignore: cast_nullable_to_non_nullable
              as String?,
      skipCount: null == skipCount
          ? _value.skipCount
          : skipCount // ignore: cast_nullable_to_non_nullable
              as int,
      maxResultCount: null == maxResultCount
          ? _value.maxResultCount
          : maxResultCount // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChartElectricRequestImplCopyWith<$Res>
    implements $ChartElectricRequestCopyWith<$Res> {
  factory _$$ChartElectricRequestImplCopyWith(_$ChartElectricRequestImpl value,
          $Res Function(_$ChartElectricRequestImpl) then) =
      __$$ChartElectricRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'MeterId') int meterId,
      @JsonKey(name: 'Type') SearchType searchType,
      @JsonKey(name: 'FromDate') String? fromDate,
      @JsonKey(name: 'ToDate') String? toDate,
      @JsonKey(name: 'SkipCount') int skipCount,
      @JsonKey(name: 'MaxResultCount') String maxResultCount});
}

/// @nodoc
class __$$ChartElectricRequestImplCopyWithImpl<$Res>
    extends _$ChartElectricRequestCopyWithImpl<$Res, _$ChartElectricRequestImpl>
    implements _$$ChartElectricRequestImplCopyWith<$Res> {
  __$$ChartElectricRequestImplCopyWithImpl(_$ChartElectricRequestImpl _value,
      $Res Function(_$ChartElectricRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChartElectricRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meterId = null,
    Object? searchType = null,
    Object? fromDate = freezed,
    Object? toDate = freezed,
    Object? skipCount = null,
    Object? maxResultCount = null,
  }) {
    return _then(_$ChartElectricRequestImpl(
      meterId: null == meterId
          ? _value.meterId
          : meterId // ignore: cast_nullable_to_non_nullable
              as int,
      searchType: null == searchType
          ? _value.searchType
          : searchType // ignore: cast_nullable_to_non_nullable
              as SearchType,
      fromDate: freezed == fromDate
          ? _value.fromDate
          : fromDate // ignore: cast_nullable_to_non_nullable
              as String?,
      toDate: freezed == toDate
          ? _value.toDate
          : toDate // ignore: cast_nullable_to_non_nullable
              as String?,
      skipCount: null == skipCount
          ? _value.skipCount
          : skipCount // ignore: cast_nullable_to_non_nullable
              as int,
      maxResultCount: null == maxResultCount
          ? _value.maxResultCount
          : maxResultCount // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChartElectricRequestImpl implements _ChartElectricRequest {
  const _$ChartElectricRequestImpl(
      {@JsonKey(name: 'MeterId') required this.meterId,
      @JsonKey(name: 'Type') required this.searchType,
      @JsonKey(name: 'FromDate') this.fromDate,
      @JsonKey(name: 'ToDate') this.toDate,
      @JsonKey(name: 'SkipCount') this.skipCount = 0,
      @JsonKey(name: 'MaxResultCount') this.maxResultCount = "0x7fffffff"});

  factory _$ChartElectricRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChartElectricRequestImplFromJson(json);

  @override
  @JsonKey(name: 'MeterId')
  final int meterId;
  @override
  @JsonKey(name: 'Type')
  final SearchType searchType;
  @override
  @JsonKey(name: 'FromDate')
  final String? fromDate;
  @override
  @JsonKey(name: 'ToDate')
  final String? toDate;
  @override
  @JsonKey(name: 'SkipCount')
  final int skipCount;
  @override
  @JsonKey(name: 'MaxResultCount')
  final String maxResultCount;

  @override
  String toString() {
    return 'ChartElectricRequest(meterId: $meterId, searchType: $searchType, fromDate: $fromDate, toDate: $toDate, skipCount: $skipCount, maxResultCount: $maxResultCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChartElectricRequestImpl &&
            (identical(other.meterId, meterId) || other.meterId == meterId) &&
            (identical(other.searchType, searchType) ||
                other.searchType == searchType) &&
            (identical(other.fromDate, fromDate) ||
                other.fromDate == fromDate) &&
            (identical(other.toDate, toDate) || other.toDate == toDate) &&
            (identical(other.skipCount, skipCount) ||
                other.skipCount == skipCount) &&
            (identical(other.maxResultCount, maxResultCount) ||
                other.maxResultCount == maxResultCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, meterId, searchType, fromDate,
      toDate, skipCount, maxResultCount);

  /// Create a copy of ChartElectricRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChartElectricRequestImplCopyWith<_$ChartElectricRequestImpl>
      get copyWith =>
          __$$ChartElectricRequestImplCopyWithImpl<_$ChartElectricRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChartElectricRequestImplToJson(
      this,
    );
  }
}

abstract class _ChartElectricRequest implements ChartElectricRequest {
  const factory _ChartElectricRequest(
          {@JsonKey(name: 'MeterId') required final int meterId,
          @JsonKey(name: 'Type') required final SearchType searchType,
          @JsonKey(name: 'FromDate') final String? fromDate,
          @JsonKey(name: 'ToDate') final String? toDate,
          @JsonKey(name: 'SkipCount') final int skipCount,
          @JsonKey(name: 'MaxResultCount') final String maxResultCount}) =
      _$ChartElectricRequestImpl;

  factory _ChartElectricRequest.fromJson(Map<String, dynamic> json) =
      _$ChartElectricRequestImpl.fromJson;

  @override
  @JsonKey(name: 'MeterId')
  int get meterId;
  @override
  @JsonKey(name: 'Type')
  SearchType get searchType;
  @override
  @JsonKey(name: 'FromDate')
  String? get fromDate;
  @override
  @JsonKey(name: 'ToDate')
  String? get toDate;
  @override
  @JsonKey(name: 'SkipCount')
  int get skipCount;
  @override
  @JsonKey(name: 'MaxResultCount')
  String get maxResultCount;

  /// Create a copy of ChartElectricRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChartElectricRequestImplCopyWith<_$ChartElectricRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
