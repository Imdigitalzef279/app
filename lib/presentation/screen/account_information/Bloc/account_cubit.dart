import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:solar_energy/application/enums/load_status.dart';
import 'package:solar_energy/data/dto/profile/profile_response.dart';
import 'package:solar_energy/data/repositories/auth/auth_repository.dart';

import '../../../../data/data_sources/storage/shared_preferences/shared_preferences_helper.dart';
import '../../../../data/dto/result/result.dart';

part 'account_cubit.freezed.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountState.initial());

  final authRepository = GetIt.instance<AuthRepository>();
  final sharedPreferences = GetIt.instance<SharedPreferencesHelper>();

  void removeToken() async {
    await sharedPreferences.removeAccessToken();
  }

  Future<void> getProfile() async {
    try {
      emit(state.copyWith(request: Result(status: LoadStatus.loading)));
      final response = await authRepository.getProfile();
      if (response.isSuccess) {
        emit(state.copyWith(
            request: Result(status: LoadStatus.success, data: response.data)));
        return;
      }
      emit(state.copyWith(request: Result(status: LoadStatus.failure)));
    } catch (e) {
      emit(state.copyWith(request: Result(status: LoadStatus.failure)));
    }
  }
}
