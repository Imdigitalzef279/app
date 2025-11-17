import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:solar_energy/application/enums/load_status.dart';
import 'package:solar_energy/data/dto/profile/profile_response.dart';
import 'package:solar_energy/data/repositories/auth/auth_repository.dart';
import 'package:solar_energy/presentation/common_widgets/app_toast.dart';

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

  Future<bool> deleteAccount() async {
    try {
      emit(state.copyWith(
          status: LoadStatus.loading,
          request: Result(status: LoadStatus.loading)));
      const apiUrl = 'http://160.30.136.145:5025/api/user/';
      final token = await sharedPreferences.getAccessToken();

      if (token.isEmpty) return false;

      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      final uniqueName = decodedToken['unique_name'];

      print("unique_name	: ${uniqueName.toString()}");

      if (uniqueName == null) return false;

      final response = await Dio().post('$apiUrl$uniqueName');

      if (response.data == null || response.data.toString() != uniqueName) {
        emit(state.copyWith(
          status: LoadStatus.failure,
          error: "Tên người dùng không khớp hoặc không tồn tại.",
          request: Result(status: LoadStatus.failure),
        ));
        AppToast.showToastSuccess(
            title: "Tên người dùng không khớp hoặc không tồn tại.");
        return false;
      }

      emit(state.copyWith(
          status: LoadStatus.success,
          request: Result(status: LoadStatus.success)));
      AppToast.showToastSuccess(title: "Xóa tài khoản thành công!!");
      removeToken();
      return true;
    } catch (e) {
      emit(state.copyWith(
          status: LoadStatus.failure,
          error: "Đã có lỗi xảy ra!!!",
          request: Result(status: LoadStatus.failure)));
      AppToast.showToastSuccess(title: "Đã có lỗi xảy ra!!!");
      return false;
    }
  }
}
