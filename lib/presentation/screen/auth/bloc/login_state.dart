part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({required AuthRequest request}) = _LoginState;

  factory LoginState.initial() => const LoginState(
      request: AuthRequest(
          username: '',
          password: '',
          grantType: 'password',
          clientId: 'MonitorSystem_App',
          scope: 'MonitorSystem offline_access'));
}
