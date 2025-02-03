part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({required Result<AuthRequest> request}) = _LoginState;

  factory LoginState.initial() =>  LoginState(
      request: Result(
        data: const AuthRequest(
            username: '',
            password: '',
            grantType: 'password',
            clientId: 'MonitorSystem_App',
            scope: 'MonitorSystem offline_access')
      ));
}
