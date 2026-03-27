part of 'register_cubit.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState({
    @Default("") String gmail,
    @Default("") String gmailError,
    @Default("") String name,
    @Default("") String nameError,
    @Default("") String phoneNumber,
    @Default("") String phoneNumberError,
    @Default("") String accountName,
    @Default("") String accountNameError,
    @Default("") String password,
    @Default("") String passwordError,
    @Default("") String confirmPassword,
    @Default("") String confirmPasswordError,
    @Default("") String surname,
    @Default("") String surnameError,
    @Default("") String message,
    @Default(false) bool showPass,
    @Default(false) bool showPassConfirm,
    @Default(LoadStatus.initial) LoadStatus loadStatus,
    @Default(false) bool isAgree,
  }) = _RegisterState;

  factory RegisterState.init() => const RegisterState();
}
