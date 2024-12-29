// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detail_factory_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DetailFactoryState {
  Result<PaginationResponse<SolarElectricResponse>> get resultSolar =>
      throw _privateConstructorUsedError;

  /// Create a copy of DetailFactoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DetailFactoryStateCopyWith<DetailFactoryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetailFactoryStateCopyWith<$Res> {
  factory $DetailFactoryStateCopyWith(
          DetailFactoryState value, $Res Function(DetailFactoryState) then) =
      _$DetailFactoryStateCopyWithImpl<$Res, DetailFactoryState>;
  @useResult
  $Res call({Result<PaginationResponse<SolarElectricResponse>> resultSolar});

  $ResultCopyWith<PaginationResponse<SolarElectricResponse>, $Res>
      get resultSolar;
}

/// @nodoc
class _$DetailFactoryStateCopyWithImpl<$Res, $Val extends DetailFactoryState>
    implements $DetailFactoryStateCopyWith<$Res> {
  _$DetailFactoryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DetailFactoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultSolar = null,
  }) {
    return _then(_value.copyWith(
      resultSolar: null == resultSolar
          ? _value.resultSolar
          : resultSolar // ignore: cast_nullable_to_non_nullable
              as Result<PaginationResponse<SolarElectricResponse>>,
    ) as $Val);
  }

  /// Create a copy of DetailFactoryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ResultCopyWith<PaginationResponse<SolarElectricResponse>, $Res>
      get resultSolar {
    return $ResultCopyWith<PaginationResponse<SolarElectricResponse>, $Res>(
        _value.resultSolar, (value) {
      return _then(_value.copyWith(resultSolar: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DetailFactoryStateImplCopyWith<$Res>
    implements $DetailFactoryStateCopyWith<$Res> {
  factory _$$DetailFactoryStateImplCopyWith(_$DetailFactoryStateImpl value,
          $Res Function(_$DetailFactoryStateImpl) then) =
      __$$DetailFactoryStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Result<PaginationResponse<SolarElectricResponse>> resultSolar});

  @override
  $ResultCopyWith<PaginationResponse<SolarElectricResponse>, $Res>
      get resultSolar;
}

/// @nodoc
class __$$DetailFactoryStateImplCopyWithImpl<$Res>
    extends _$DetailFactoryStateCopyWithImpl<$Res, _$DetailFactoryStateImpl>
    implements _$$DetailFactoryStateImplCopyWith<$Res> {
  __$$DetailFactoryStateImplCopyWithImpl(_$DetailFactoryStateImpl _value,
      $Res Function(_$DetailFactoryStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of DetailFactoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultSolar = null,
  }) {
    return _then(_$DetailFactoryStateImpl(
      resultSolar: null == resultSolar
          ? _value.resultSolar
          : resultSolar // ignore: cast_nullable_to_non_nullable
              as Result<PaginationResponse<SolarElectricResponse>>,
    ));
  }
}

/// @nodoc

class _$DetailFactoryStateImpl implements _DetailFactoryState {
  const _$DetailFactoryStateImpl({required this.resultSolar});

  @override
  final Result<PaginationResponse<SolarElectricResponse>> resultSolar;

  @override
  String toString() {
    return 'DetailFactoryState(resultSolar: $resultSolar)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DetailFactoryStateImpl &&
            (identical(other.resultSolar, resultSolar) ||
                other.resultSolar == resultSolar));
  }

  @override
  int get hashCode => Object.hash(runtimeType, resultSolar);

  /// Create a copy of DetailFactoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DetailFactoryStateImplCopyWith<_$DetailFactoryStateImpl> get copyWith =>
      __$$DetailFactoryStateImplCopyWithImpl<_$DetailFactoryStateImpl>(
          this, _$identity);
}

abstract class _DetailFactoryState implements DetailFactoryState {
  const factory _DetailFactoryState(
      {required final Result<PaginationResponse<SolarElectricResponse>>
          resultSolar}) = _$DetailFactoryStateImpl;

  @override
  Result<PaginationResponse<SolarElectricResponse>> get resultSolar;

  /// Create a copy of DetailFactoryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DetailFactoryStateImplCopyWith<_$DetailFactoryStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
