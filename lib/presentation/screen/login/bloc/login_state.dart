part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required Result<AuthRequest> request,
    @Default("") String userName,
    @Default("") String password,
    @Default(true) bool clause,
    @Default("") String errorUserName,
    @Default("") String errorPassword,
    @Default("") String error,
    @Default(false) bool showPass,
  }) = _LoginState;

  factory LoginState.initial() => LoginState(
      request: Result(
          data: const AuthRequest(
              username: '',
              password: '',
              grantType: 'password',
              clientId: 'MonitorSystem_App',
              scope: 'MonitorSystem offline_access')));
}
