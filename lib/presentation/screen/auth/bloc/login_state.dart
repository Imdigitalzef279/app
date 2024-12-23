part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({required AuthRequest request}) = _LoginState;

  factory LoginState.initial() =>
      const LoginState(request: AuthRequest(userName: '', password: ''));
}
