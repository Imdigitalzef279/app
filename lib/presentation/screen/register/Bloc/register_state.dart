part of 'register_cubit.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState({
    @Default("") String gmail,
    @Default("") String gmailError,
    @Default("") String fullName,
    @Default("") String fullNameError,
    @Default("") String phoneNumber,
    @Default("") String phoneNumberError,
    @Default("") String accountName,
    @Default("") String accountNameError,
    @Default("") String password,
    @Default("") String passwordError,
    @Default("") String confirmPassword,
    @Default("") String confirmPasswordError,
    @Default("") String projectName,
    @Default("") String projectNameError,
    @Default("") String descriptionProject,
    @Default("") String descriptionProjectError,
    @Default("") String message,
    @Default(false) bool showPass,
    @Default(false) bool showPassConfirm,
    @Default(LoadStatus.initial) LoadStatus loadStatus,
  }) = _RegisterState;

  factory RegisterState.init() => const RegisterState();
}
