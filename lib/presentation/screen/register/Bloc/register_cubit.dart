import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:solar_energy/application/constants/mail.dart';
import 'package:solar_energy/application/enums/load_status.dart';

part 'register_state.dart';

part 'register_cubit.freezed.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterState.init());

  final smtpServer = gmail(MailSMTP.GMAIL_MAIL, MailSMTP.GMAIL_PASSWORD);
  final notNull = "Không được để trống";
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  final RegExp phoneRegex = RegExp(r'^\d{10}$');
  final RegExp passwordRegex =
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$');

  Future<void> sendMail() async {
    final messageToUser = Message()
      ..from = const Address(MailSMTP.GMAIL_MAIL, 'KARA GROUP')
      ..recipients.add(state.gmail)
      ..subject = 'Cảm ơn bạn đã đăng ký'
      ..text = 'Chúng tôi đã nhận được thông tin của bạn và sẽ liên hệ sớm.'
      ..html = '''
    <h3>Thông tin đăng ký</h3>
    <ul>
      <li>Email người dùng: ${state.gmail}</li>
      <li>Tên: ${state.fullName}</li>
      <li>SĐT: ${state.phoneNumber}</li>
      <li>Tài khoản: ${state.accountName}</li>
      <li>Dự án: ${state.projectName}</li>
      <li>Mô tả dự án: ${state.descriptionProject}</li>
    </ul>
  ''';

    final messageToAdmin = Message()
      ..from = const Address(MailSMTP.GMAIL_MAIL, 'KARA GROUP')
      ..recipients.add(MailSMTP.GMAIL_MAIL)
      ..subject = 'Người dùng mới đã đăng ký'
      ..text = '''
        Người dùng vừa đăng ký với các thông tin:
        Email người dùng: ${state.gmail}
        Tên: ${state.fullName}
        SĐT: ${state.phoneNumber}
        Tài khoản: ${state.accountName}
        Mật khẩu: ${state.password}
        Dự án: ${state.projectName}
        Mô tả dự án: ${state.descriptionProject}
    ''';

    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      final sendUser = await send(messageToUser, smtpServer);
      final sendAdmin = await send(messageToAdmin, smtpServer);
      emit(state.copyWith(
          loadStatus: LoadStatus.success,
          message:
              "Tài khoản của bạn sẽ được đăng ký trong vòng 2 ngày. Vui lòng kiêm tra gmail!"));
    } on MailerException catch (e) {
      emit(state.copyWith(
          loadStatus: LoadStatus.failure,
          message: "Đăng ký thất bại. Vui lòng liên hệ quản trị viên."));
    }
  }

  changeQuery(
      {String? mail,
      String? name,
      String? phoneNumber,
      String? accountName,
      String? password,
      String? confirmPassword,
      String? projectName,
      String? descriptionProject,
      String? mailError,
      String? nameError,
      String? phoneNumberError,
      String? accountNameError,
      String? passwordError,
      String? confirmPasswordError,
      String? projectNameError,
      String? descriptionProjectError,
      String? message,
      bool? showPass,
      bool? showPassConfirm}) {
    emit(state.copyWith(
        password: password ?? state.password,
        gmail: mail ?? state.gmail,
        fullName: name ?? state.fullName,
        phoneNumber: phoneNumber ?? state.phoneNumber,
        accountName: accountName ?? state.accountName,
        confirmPassword: confirmPassword ?? state.confirmPassword,
        projectName: projectName ?? state.projectName,
        descriptionProject: descriptionProject ?? state.descriptionProject,
        passwordError: passwordError ?? state.passwordError,
        gmailError: mailError ?? state.gmailError,
        fullNameError: nameError ?? state.fullNameError,
        phoneNumberError: phoneNumberError ?? state.phoneNumberError,
        accountNameError: accountNameError ?? state.accountNameError,
        confirmPasswordError:
            confirmPasswordError ?? state.confirmPasswordError,
        projectNameError: projectNameError ?? state.projectNameError,
        descriptionProjectError:
            descriptionProjectError ?? state.descriptionProjectError,
        message: message ?? state.message,
        showPass: showPass ?? state.showPass,
        showPassConfirm: showPassConfirm ?? state.showPassConfirm));
  }

  bool validate() {
    return validateEmail() &&
        validateName() &&
        validatePhone() &&
        validateAccount() &&
        validatePass() &&
        validateConfirmPass() &&
        validateProjectName() &&
        validateProjectDescription();
  }

  bool validateEmail() {
    if (state.gmail.isEmpty) {
      emit(state.copyWith(gmailError: notNull));
      return false;
    }
    if (!emailRegex.hasMatch(state.gmail)) {
      emit(state.copyWith(gmailError: "Email không đúng định dạng"));
      return false;
    }
    emit(state.copyWith(gmailError: ""));
    return true;
  }

  bool validateName() {
    if (state.fullName.isEmpty) {
      emit(state.copyWith(fullNameError: notNull));
      return false;
    }
    emit(state.copyWith(fullNameError: ""));
    return true;
  }

  bool validatePhone() {
    if (state.phoneNumber.isEmpty) {
      emit(state.copyWith(phoneNumberError: notNull));
      return false;
    }
    if (!phoneRegex.hasMatch(state.phoneNumber)) {
      emit(state.copyWith(
          phoneNumberError: "Số điện thoại không đúng định dạng"));
      return false;
    }
    emit(state.copyWith(phoneNumberError: ""));
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
              "Mật khẩu phải có 8 ký tự, ít nhất 1 chứ thường, 1 chữ hoa, 1 ký tự đặc biệt và 1 chữ số"));
      return false;
    }
    emit(state.copyWith(passwordError: ""));
    return true;
  }

  bool validateConfirmPass() {
    if (state.confirmPassword != state.password) {
      emit(state.copyWith(confirmPasswordError: "Mật khẩu không khớp"));
      return false;
    }
    emit(state.copyWith(confirmPasswordError: ""));
    return true;
  }

  bool validateProjectName() {
    if (state.projectName.isEmpty) {
      emit(state.copyWith(projectNameError: notNull));
      return false;
    }
    emit(state.copyWith(projectNameError: ""));
    return true;
  }

  bool validateProjectDescription() {
    if (state.descriptionProject.isEmpty) {
      emit(state.copyWith(descriptionProjectError: notNull));
      return false;
    }
    emit(state.copyWith(descriptionProjectError: ""));
    return true;
  }
}
