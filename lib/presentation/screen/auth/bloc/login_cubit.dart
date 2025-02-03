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

  void changeRequest(AuthRequest request) {
    emit(state.copyWith(request: Result(data: request)));
  }

  Future<bool> login() async {
    try{
      emit(state.copyWith(request: Result(status: LoadStatus.loading)));
      final response = await authRepository.signIn(state.request.data!);
      if(response.isSuccess){
        if(response.data?.accessToken != null){
          sharedPreferences.setAccessToken(response.data!.accessToken);
          return true;
        }
        return false;
      }
      return false;
    }catch (e){
      return false;
    }
  }
}
