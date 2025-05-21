import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:solar_energy/application/enums/load_status.dart';
import 'package:solar_energy/data/dto/auth/request/auth_request.dart';
import 'package:solar_energy/data/repositories/auth/auth_repository.dart';

import '../../../../data/data_sources/storage/shared_preferences/shared_preferences_helper.dart';
import '../../../../data/dto/result/result.dart';

part 'login_cubit.freezed.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState.initial());

  final authRepository = GetIt.instance<AuthRepository>();
  final sharedPreferences = GetIt.instance<SharedPreferencesHelper>();

  void changeRequest() {
    emit(state.copyWith(
        request: Result(
            data: state.request.data?.copyWith(
                password: state.password, username: state.userName))));
  }

  void changeDataQuery({String? userName, String? password, bool? clause}) {
    emit(state.copyWith(
        userName: userName ?? state.userName,
        password: password ?? state.password,
        clause: clause ?? state.clause));
  }

  void showPass(){
    emit(state.copyWith(showPass: !state.showPass));
  }

  bool checkClause(){
    return state.clause;
  }

  bool checkUserName(){
    if(state.userName == ""){
      emit(state.copyWith(errorUserName: "Không được để trống"));
      return false;
    }
    emit(state.copyWith(errorUserName: ""));
    return true;
  }

  bool checkPassword(){
    if(state.password == ""){
      emit(state.copyWith(errorPassword: "Không được để trống"));
    return false;
  }
    emit(state.copyWith(errorPassword: ""));
    return true;
  }

  bool checkLogin(){
    return   checkUserName() && checkPassword() && checkClause();
  }

  Future<void> login() async {
    if(checkLogin()){
      try {
        emit(state.copyWith(request: Result(status: LoadStatus.loading)));
        changeRequest();
        final response = await authRepository.signIn(AuthRequest(
            username: state.userName,
            password: state.password,
            grantType: 'password',
            clientId: 'MonitorSystem_App',
            scope: 'MonitorSystem offline_access'));
        if (response.isSuccess) {
          if (response.data?.accessToken != null) {
            sharedPreferences.setAccessToken(response.data!.accessToken);
            emit(state.copyWith(request: Result(status: LoadStatus.success)));
            return;
          }
          emit(state.copyWith(request: Result(status: LoadStatus.failure)));
          return;
        }
        emit(state.copyWith(request: Result(status: LoadStatus.failure),error:  response.error));
        return;
      } catch (e) {
        emit(state.copyWith(request: Result(status: LoadStatus.failure)));
        return;
      }
    }
  }

  Future<bool> checkToken() async{
    emit(state.copyWith(request: Result(status: LoadStatus.loading)));
    final token = await sharedPreferences.getAccessToken();
    if (token.isNotEmpty) {
      emit(state.copyWith(request: Result(status: LoadStatus.success)));
      return true;
    }
    emit(state.copyWith(request: Result(status: LoadStatus.failure)));
    return false;
  }
}
