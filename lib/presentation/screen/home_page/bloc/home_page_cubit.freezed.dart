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
  Result<PaginationResponse<ProjectResponse>> get resultProjects =>
      throw _privateConstructorUsedError;
  ProjectRequest get request => throw _privateConstructorUsedError;

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
      {Result<PaginationResponse<ProjectResponse>> resultProjects,
      ProjectRequest request});

  $ResultCopyWith<PaginationResponse<ProjectResponse>, $Res> get resultProjects;
  $ProjectRequestCopyWith<$Res> get request;
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
    Object? request = null,
  }) {
    return _then(_value.copyWith(
      resultProjects: null == resultProjects
          ? _value.resultProjects
          : resultProjects // ignore: cast_nullable_to_non_nullable
              as Result<PaginationResponse<ProjectResponse>>,
      request: null == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as ProjectRequest,
    ) as $Val);
  }

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ResultCopyWith<PaginationResponse<ProjectResponse>, $Res>
      get resultProjects {
    return $ResultCopyWith<PaginationResponse<ProjectResponse>, $Res>(
        _value.resultProjects, (value) {
      return _then(_value.copyWith(resultProjects: value) as $Val);
    });
  }

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProjectRequestCopyWith<$Res> get request {
    return $ProjectRequestCopyWith<$Res>(_value.request, (value) {
      return _then(_value.copyWith(request: value) as $Val);
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
      {Result<PaginationResponse<ProjectResponse>> resultProjects,
      ProjectRequest request});

  @override
  $ResultCopyWith<PaginationResponse<ProjectResponse>, $Res> get resultProjects;
  @override
  $ProjectRequestCopyWith<$Res> get request;
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
    Object? request = null,
  }) {
    return _then(_$HomePageStateImpl(
      resultProjects: null == resultProjects
          ? _value.resultProjects
          : resultProjects // ignore: cast_nullable_to_non_nullable
              as Result<PaginationResponse<ProjectResponse>>,
      request: null == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as ProjectRequest,
    ));
  }
}

/// @nodoc

class _$HomePageStateImpl implements _HomePageState {
  const _$HomePageStateImpl(
      {required this.resultProjects, required this.request});

  @override
  final Result<PaginationResponse<ProjectResponse>> resultProjects;
  @override
  final ProjectRequest request;

  @override
  String toString() {
    return 'HomePageState(resultProjects: $resultProjects, request: $request)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomePageStateImpl &&
            (identical(other.resultProjects, resultProjects) ||
                other.resultProjects == resultProjects) &&
            (identical(other.request, request) || other.request == request));
  }

  @override
  int get hashCode => Object.hash(runtimeType, resultProjects, request);

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
      {required final Result<PaginationResponse<ProjectResponse>>
          resultProjects,
      required final ProjectRequest request}) = _$HomePageStateImpl;

  @override
  Result<PaginationResponse<ProjectResponse>> get resultProjects;
  @override
  ProjectRequest get request;

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomePageStateImplCopyWith<_$HomePageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
