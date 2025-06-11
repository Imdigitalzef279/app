// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_page_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomePageState {
  Result<List<PowerStationResponse>> get resultProjects =>
      throw _privateConstructorUsedError; //required ProjectRequest request,
  int get projectID => throw _privateConstructorUsedError;
  int get allStation => throw _privateConstructorUsedError;
  int get active => throw _privateConstructorUsedError;
  int get warning => throw _privateConstructorUsedError;
  int get loss => throw _privateConstructorUsedError;

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomePageStateCopyWith<HomePageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomePageStateCopyWith<$Res> {
  factory $HomePageStateCopyWith(
          HomePageState value, $Res Function(HomePageState) then) =
      _$HomePageStateCopyWithImpl<$Res, HomePageState>;
  @useResult
  $Res call(
      {Result<List<PowerStationResponse>> resultProjects,
      int projectID,
      int allStation,
      int active,
      int warning,
      int loss});

  $ResultCopyWith<List<PowerStationResponse>, $Res> get resultProjects;
}

/// @nodoc
class _$HomePageStateCopyWithImpl<$Res, $Val extends HomePageState>
    implements $HomePageStateCopyWith<$Res> {
  _$HomePageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultProjects = null,
    Object? projectID = null,
    Object? allStation = null,
    Object? active = null,
    Object? warning = null,
    Object? loss = null,
  }) {
    return _then(_value.copyWith(
      resultProjects: null == resultProjects
          ? _value.resultProjects
          : resultProjects // ignore: cast_nullable_to_non_nullable
              as Result<List<PowerStationResponse>>,
      projectID: null == projectID
          ? _value.projectID
          : projectID // ignore: cast_nullable_to_non_nullable
              as int,
      allStation: null == allStation
          ? _value.allStation
          : allStation // ignore: cast_nullable_to_non_nullable
              as int,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as int,
      warning: null == warning
          ? _value.warning
          : warning // ignore: cast_nullable_to_non_nullable
              as int,
      loss: null == loss
          ? _value.loss
          : loss // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ResultCopyWith<List<PowerStationResponse>, $Res> get resultProjects {
    return $ResultCopyWith<List<PowerStationResponse>, $Res>(
        _value.resultProjects, (value) {
      return _then(_value.copyWith(resultProjects: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HomePageStateImplCopyWith<$Res>
    implements $HomePageStateCopyWith<$Res> {
  factory _$$HomePageStateImplCopyWith(
          _$HomePageStateImpl value, $Res Function(_$HomePageStateImpl) then) =
      __$$HomePageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Result<List<PowerStationResponse>> resultProjects,
      int projectID,
      int allStation,
      int active,
      int warning,
      int loss});

  @override
  $ResultCopyWith<List<PowerStationResponse>, $Res> get resultProjects;
}

/// @nodoc
class __$$HomePageStateImplCopyWithImpl<$Res>
    extends _$HomePageStateCopyWithImpl<$Res, _$HomePageStateImpl>
    implements _$$HomePageStateImplCopyWith<$Res> {
  __$$HomePageStateImplCopyWithImpl(
      _$HomePageStateImpl _value, $Res Function(_$HomePageStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultProjects = null,
    Object? projectID = null,
    Object? allStation = null,
    Object? active = null,
    Object? warning = null,
    Object? loss = null,
  }) {
    return _then(_$HomePageStateImpl(
      resultProjects: null == resultProjects
          ? _value.resultProjects
          : resultProjects // ignore: cast_nullable_to_non_nullable
              as Result<List<PowerStationResponse>>,
      projectID: null == projectID
          ? _value.projectID
          : projectID // ignore: cast_nullable_to_non_nullable
              as int,
      allStation: null == allStation
          ? _value.allStation
          : allStation // ignore: cast_nullable_to_non_nullable
              as int,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as int,
      warning: null == warning
          ? _value.warning
          : warning // ignore: cast_nullable_to_non_nullable
              as int,
      loss: null == loss
          ? _value.loss
          : loss // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$HomePageStateImpl implements _HomePageState {
  const _$HomePageStateImpl(
      {required this.resultProjects,
      this.projectID = 0,
      this.allStation = 0,
      this.active = 0,
      this.warning = 0,
      this.loss = 0});

  @override
  final Result<List<PowerStationResponse>> resultProjects;
//required ProjectRequest request,
  @override
  @JsonKey()
  final int projectID;
  @override
  @JsonKey()
  final int allStation;
  @override
  @JsonKey()
  final int active;
  @override
  @JsonKey()
  final int warning;
  @override
  @JsonKey()
  final int loss;

  @override
  String toString() {
    return 'HomePageState(resultProjects: $resultProjects, projectID: $projectID, allStation: $allStation, active: $active, warning: $warning, loss: $loss)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomePageStateImpl &&
            (identical(other.resultProjects, resultProjects) ||
                other.resultProjects == resultProjects) &&
            (identical(other.projectID, projectID) ||
                other.projectID == projectID) &&
            (identical(other.allStation, allStation) ||
                other.allStation == allStation) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.warning, warning) || other.warning == warning) &&
            (identical(other.loss, loss) || other.loss == loss));
  }

  @override
  int get hashCode => Object.hash(runtimeType, resultProjects, projectID,
      allStation, active, warning, loss);

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomePageStateImplCopyWith<_$HomePageStateImpl> get copyWith =>
      __$$HomePageStateImplCopyWithImpl<_$HomePageStateImpl>(this, _$identity);
}

abstract class _HomePageState implements HomePageState {
  const factory _HomePageState(
      {required final Result<List<PowerStationResponse>> resultProjects,
      final int projectID,
      final int allStation,
      final int active,
      final int warning,
      final int loss}) = _$HomePageStateImpl;

  @override
  Result<List<PowerStationResponse>>
      get resultProjects; //required ProjectRequest request,
  @override
  int get projectID;
  @override
  int get allStation;
  @override
  int get active;
  @override
  int get warning;
  @override
  int get loss;

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomePageStateImplCopyWith<_$HomePageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
