import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solar_energy/data/dto/auth/request/auth_request.dart';

part 'login_cubit.freezed.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState.initial());

  void changeRequest(AuthRequest request) {
    emit(state.copyWith(request: request));
  }

  bool login() {
    return state.request.userName == 'admin' &&
        state.request.password == 'admin';
  }
}
