
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoginState {
  Result<AuthRequest> get request => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  bool get clause => throw _privateConstructorUsedError;
  String get errorUserName => throw _privateConstructorUsedError;
  String get errorPassword => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  bool get showPass => throw _privateConstructorUsedError;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginStateCopyWith<LoginState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
          LoginState value, $Res Function(LoginState) then) =
      _$LoginStateCopyWithImpl<$Res, LoginState>;
  @useResult
  $Res call(
      {Result<AuthRequest> request,
      String userName,
      String password,
      bool clause,
      String errorUserName,
      String errorPassword,
      String error,
      bool showPass});

  $ResultCopyWith<AuthRequest, $Res> get request;
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res, $Val extends LoginState>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? request = null,
    Object? userName = null,
    Object? password = null,
    Object? clause = null,
    Object? errorUserName = null,
    Object? errorPassword = null,
    Object? error = null,
    Object? showPass = null,
  }) {
    return _then(_value.copyWith(
      request: null == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as Result<AuthRequest>,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      clause: null == clause
          ? _value.clause
          : clause // ignore: cast_nullable_to_non_nullable
              as bool,
      errorUserName: null == errorUserName
          ? _value.errorUserName
          : errorUserName // ignore: cast_nullable_to_non_nullable
              as String,
      errorPassword: null == errorPassword
          ? _value.errorPassword
          : errorPassword // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      showPass: null == showPass
          ? _value.showPass
          : showPass // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ResultCopyWith<AuthRequest, $Res> get request {
    return $ResultCopyWith<AuthRequest, $Res>(_value.request, (value) {
      return _then(_value.copyWith(request: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoginStateImplCopyWith<$Res>
    implements $LoginStateCopyWith<$Res> {
  factory _$$LoginStateImplCopyWith(
          _$LoginStateImpl value, $Res Function(_$LoginStateImpl) then) =
      __$$LoginStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Result<AuthRequest> request,
      String userName,
      String password,
      bool clause,
      String errorUserName,
      String errorPassword,
      String error,
      bool showPass});

  @override
  $ResultCopyWith<AuthRequest, $Res> get request;
}

/// @nodoc
class __$$LoginStateImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$LoginStateImpl>
    implements _$$LoginStateImplCopyWith<$Res> {
  __$$LoginStateImplCopyWithImpl(
      _$LoginStateImpl _value, $Res Function(_$LoginStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? request = null,
    Object? userName = null,
    Object? password = null,
    Object? clause = null,
    Object? errorUserName = null,
    Object? errorPassword = null,
    Object? error = null,
    Object? showPass = null,
  }) {
    return _then(_$LoginStateImpl(
      request: null == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as Result<AuthRequest>,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      clause: null == clause
          ? _value.clause
          : clause // ignore: cast_nullable_to_non_nullable
              as bool,
      errorUserName: null == errorUserName
          ? _value.errorUserName
          : errorUserName // ignore: cast_nullable_to_non_nullable
              as String,
      errorPassword: null == errorPassword
          ? _value.errorPassword
          : errorPassword // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      showPass: null == showPass
          ? _value.showPass
          : showPass // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$LoginStateImpl implements _LoginState {
  const _$LoginStateImpl(
      {required this.request,
      this.userName = "",
      this.password = "",
      this.clause = false,
      this.errorUserName = "",
      this.errorPassword = "",
      this.error = "",
      this.showPass = false});

  @override
  final Result<AuthRequest> request;
  @override
  @JsonKey()
  final String userName;
  @override
  @JsonKey()
  final String password;
  @override
  @JsonKey()
  final bool clause;
  @override
  @JsonKey()
  final String errorUserName;
  @override
  @JsonKey()
  final String errorPassword;
  @override
  @JsonKey()
  final String error;
  @override
  @JsonKey()
  final bool showPass;

  @override
  String toString() {
    return 'LoginState(request: $request, userName: $userName, password: $password, clause: $clause, errorUserName: $errorUserName, errorPassword: $errorPassword, error: $error, showPass: $showPass)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginStateImpl &&
            (identical(other.request, request) || other.request == request) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.clause, clause) || other.clause == clause) &&
            (identical(other.errorUserName, errorUserName) ||
                other.errorUserName == errorUserName) &&
            (identical(other.errorPassword, errorPassword) ||
                other.errorPassword == errorPassword) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.showPass, showPass) ||
                other.showPass == showPass));
  }

  @override
  int get hashCode => Object.hash(runtimeType, request, userName, password,
      clause, errorUserName, errorPassword, error, showPass);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith =>
      __$$LoginStateImplCopyWithImpl<_$LoginStateImpl>(this, _$identity);
}

abstract class _LoginState implements LoginState {
  const factory _LoginState(
      {required final Result<AuthRequest> request,
      final String userName,
      final String password,
      final bool clause,
      final String errorUserName,
      final String errorPassword,
      final String error,
      final bool showPass}) = _$LoginStateImpl;

  @override
  Result<AuthRequest> get request;
  @override
  String get userName;
  @override
  String get password;
  @override
  bool get clause;
  @override
  String get errorUserName;
  @override
  String get errorPassword;
  @override
  String get error;
  @override
  bool get showPass;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
