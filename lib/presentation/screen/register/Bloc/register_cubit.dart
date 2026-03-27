import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/application/constants/mail.dart';
import 'package:solar_energy/application/enums/load_status.dart';
import 'package:solar_energy/data/dto/register/request/user_request.dart';

import '../../../../data/data_sources/storage/shared_preferences/shared_preferences_helper.dart';
import '../../../../data/dto/auth/request/auth_request.dart';
import '../../../../data/repositories/auth/auth_repository.dart';
import '../../../../data/repositories/register/register_repository.dart';

part 'register_state.dart';

part 'register_cubit.freezed.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterState.init());

  final registerRepo = GetIt.instance<RegisterRepository>();
  final auth = GetIt.instance<AuthRepository>();
  final sharedPreferences = GetIt.instance<SharedPreferencesHelper>();
  final authRequest = const AuthRequest(
      username: "admin",
      password: "1q2w3E*",
      grantType: 'password',
      clientId: 'MonitorSystem_App',
      scope: 'MonitorSystem offline_access');

  final smtpServer = gmail(MailSMTP.GMAIL_MAIL, MailSMTP.GMAIL_PASSWORD);
  final notNull = LocalizationsUtils.localizations.field_required;
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  final RegExp phoneRegex = RegExp(r'^\d{10}$');
  final RegExp passwordRegex =
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$');

  Future<void> registerUser() async {
    try {
      emit(
        state.copyWith(loadStatus: LoadStatus.loading),
      );

      final token = await auth.signIn(authRequest);
      await sharedPreferences.setAccessToken(token.data?.accessToken ?? "");

      final response = await registerRepo.register(UserRequest(
          userName: state.accountName,
          name: state.name,
          surname: state.surname,
          email: state.gmail,
          phoneNumber: state.phoneNumber,
          password: state.password));

      if (response.status == LoadStatus.failure) {
        emit(
          state.copyWith(
              message: LocalizationsUtils.localizations.an_error_occurred,
              loadStatus: LoadStatus.failure),
        );
        return;
      }
      emit(
        state.copyWith(
            message: LocalizationsUtils.localizations.registerSuccess,
            loadStatus: LoadStatus.success),
      );
    } catch (e) {
      emit(state.copyWith(
          message: LocalizationsUtils.localizations.an_error_occurred));
    }
  }

  changeQuery(
      {String? mail,
      String? name,
      String? phoneNumber,
      String? accountName,
      String? password,
      String? confirmPassword,
      String? surname,
      String? descriptionProject,
      String? mailError,
      String? nameError,
      String? phoneNumberError,
      String? accountNameError,
      String? passwordError,
      String? confirmPasswordError,
      String? surnameError,
      String? message,
      bool? showPass,
      bool? showPassConfirm,
      bool? isAgree}) {
    emit(state.copyWith(
        password: password ?? state.password,
        gmail: mail ?? state.gmail,
        name: name ?? state.name,
        phoneNumber: phoneNumber ?? state.phoneNumber,
        accountName: accountName ?? state.accountName,
        confirmPassword: confirmPassword ?? state.confirmPassword,
        surname: surname ?? state.surname,
        passwordError: passwordError ?? state.passwordError,
        gmailError: mailError ?? state.gmailError,
        nameError: nameError ?? state.nameError,
        phoneNumberError: phoneNumberError ?? state.phoneNumberError,
        accountNameError: accountNameError ?? state.accountNameError,
        confirmPasswordError:
            confirmPasswordError ?? state.confirmPasswordError,
        surnameError: surnameError ?? state.surnameError,
        message: message ?? state.message,
        showPass: showPass ?? state.showPass,
        showPassConfirm: showPassConfirm ?? state.showPassConfirm,
      isAgree: isAgree ?? state.isAgree,));
  }

  bool validate() {
    return validateEmail() &&
        validateName() &&
        validateAccount() &&
        validatePass() &&
        validateConfirmPass() &&
        validateProjectName();
  }

  bool validateEmail() {
    if (state.gmail.isEmpty) {
      emit(state.copyWith(gmailError: notNull));
      return false;
    }
    if (!emailRegex.hasMatch(state.gmail)) {
      emit(state.copyWith(
          gmailError: LocalizationsUtils.localizations.invalidEmail));
      return false;
    }
    emit(state.copyWith(gmailError: ""));
    return true;
  }

  bool validateName() {
    if (state.name.isEmpty) {
      emit(state.copyWith(nameError: notNull));
      return false;
    }
    emit(state.copyWith(nameError: ""));
    return true;
  }

  bool validateAccount() {
    if (state.accountName.isEmpty) {
      emit(state.copyWith(accountNameError: notNull));
      return false;
    }
    emit(state.copyWith(accountNameError: ""));
    return true;
  }

  bool validatePass() {
    if (state.password.isEmpty) {
      emit(state.copyWith(passwordError: notNull));
      return false;
    }
    if (!passwordRegex.hasMatch(state.password)) {
      emit(state.copyWith(
          passwordError:
              LocalizationsUtils.localizations.passwordRequirements));
      return false;
    }
    emit(state.copyWith(passwordError: ""));
    return true;
  }

  bool validateConfirmPass() {
    if (state.confirmPassword != state.password) {
      emit(state.copyWith(
          confirmPasswordError:
              LocalizationsUtils.localizations.passwordMismatch));
      return false;
    }
    emit(state.copyWith(confirmPasswordError: ""));
    return true;
  }

  bool validateProjectName() {
    if (state.surname.isEmpty) {
      emit(state.copyWith(surnameError: notNull));
      return false;
    }
    emit(state.copyWith(surnameError: ""));
    return true;
  }
}
