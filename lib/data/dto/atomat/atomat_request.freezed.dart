// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'atomat_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AtomatRequest _$AtomatRequestFromJson(Map<String, dynamic> json) {
  return _AtomatRequest.fromJson(json);
}

/// @nodoc
mixin _$AtomatRequest {
  @JsonKey(name: 'breakerSn')
  String get breakerSn => throw _privateConstructorUsedError;
  @JsonKey(name: 'fromDate')
  String get fromDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'toDate')
  String get toDate => throw _privateConstructorUsedError;

  /// Serializes this AtomatRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AtomatRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AtomatRequestCopyWith<AtomatRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AtomatRequestCopyWith<$Res> {
  factory $AtomatRequestCopyWith(
          AtomatRequest value, $Res Function(AtomatRequest) then) =
      _$AtomatRequestCopyWithImpl<$Res, AtomatRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'breakerSn') String breakerSn,
      @JsonKey(name: 'fromDate') String fromDate,
      @JsonKey(name: 'toDate') String toDate});
}

/// @nodoc
class _$AtomatRequestCopyWithImpl<$Res, $Val extends AtomatRequest>
    implements $AtomatRequestCopyWith<$Res> {
  _$AtomatRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AtomatRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? breakerSn = null,
    Object? fromDate = null,
    Object? toDate = null,
  }) {
    return _then(_value.copyWith(
      breakerSn: null == breakerSn
          ? _value.breakerSn
          : breakerSn // ignore: cast_nullable_to_non_nullable
              as String,
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
abstract class _$$AtomatRequestImplCopyWith<$Res>
    implements $AtomatRequestCopyWith<$Res> {
  factory _$$AtomatRequestImplCopyWith(
          _$AtomatRequestImpl value, $Res Function(_$AtomatRequestImpl) then) =
      __$$AtomatRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'breakerSn') String breakerSn,
      @JsonKey(name: 'fromDate') String fromDate,
      @JsonKey(name: 'toDate') String toDate});
}

/// @nodoc
class __$$AtomatRequestImplCopyWithImpl<$Res>
    extends _$AtomatRequestCopyWithImpl<$Res, _$AtomatRequestImpl>
    implements _$$AtomatRequestImplCopyWith<$Res> {
  __$$AtomatRequestImplCopyWithImpl(
      _$AtomatRequestImpl _value, $Res Function(_$AtomatRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of AtomatRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? breakerSn = null,
    Object? fromDate = null,
    Object? toDate = null,
  }) {
    return _then(_$AtomatRequestImpl(
      breakerSn: null == breakerSn
          ? _value.breakerSn
          : breakerSn // ignore: cast_nullable_to_non_nullable
              as String,
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
class _$AtomatRequestImpl implements _AtomatRequest {
  const _$AtomatRequestImpl(
      {@JsonKey(name: 'breakerSn') required this.breakerSn,
      @JsonKey(name: 'fromDate') required this.fromDate,
      @JsonKey(name: 'toDate') required this.toDate});

  factory _$AtomatRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AtomatRequestImplFromJson(json);

  @override
  @JsonKey(name: 'breakerSn')
  final String breakerSn;
  @override
  @JsonKey(name: 'fromDate')
  final String fromDate;
  @override
  @JsonKey(name: 'toDate')
  final String toDate;

  @override
  String toString() {
    return 'AtomatRequest(breakerSn: $breakerSn, fromDate: $fromDate, toDate: $toDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AtomatRequestImpl &&
            (identical(other.breakerSn, breakerSn) ||
                other.breakerSn == breakerSn) &&
            (identical(other.fromDate, fromDate) ||
                other.fromDate == fromDate) &&
            (identical(other.toDate, toDate) || other.toDate == toDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, breakerSn, fromDate, toDate);

  /// Create a copy of AtomatRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AtomatRequestImplCopyWith<_$AtomatRequestImpl> get copyWith =>
      __$$AtomatRequestImplCopyWithImpl<_$AtomatRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AtomatRequestImplToJson(
      this,
    );
  }
}

abstract class _AtomatRequest implements AtomatRequest {
  const factory _AtomatRequest(
          {@JsonKey(name: 'breakerSn') required final String breakerSn,
          @JsonKey(name: 'fromDate') required final String fromDate,
          @JsonKey(name: 'toDate') required final String toDate}) =
      _$AtomatRequestImpl;

  factory _AtomatRequest.fromJson(Map<String, dynamic> json) =
      _$AtomatRequestImpl.fromJson;

  @override
  @JsonKey(name: 'breakerSn')
  String get breakerSn;
  @override
  @JsonKey(name: 'fromDate')
  String get fromDate;
  @override
  @JsonKey(name: 'toDate')
  String get toDate;

  /// Create a copy of AtomatRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AtomatRequestImplCopyWith<_$AtomatRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
