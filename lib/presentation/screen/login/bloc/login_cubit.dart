import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/application/enums/load_status.dart';
import 'package:solar_energy/data/dto/auth/request/auth_request.dart';
import 'package:solar_energy/data/repositories/auth/auth_repository.dart';
import 'package:dio/dio.dart';
import '../../../../data/data_sources/storage/shared_preferences/shared_preferences_helper.dart';
import '../../../../data/dto/result/result.dart';

part 'login_cubit.freezed.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState.initial());

  final authRepository = GetIt.instance<AuthRepository>();
  final sharedPreferences = GetIt.instance<SharedPreferencesHelper>();
  final useNameTest = "hongln";
  final passwordTest = "123456Aa@";

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

  void showPass() {
    emit(state.copyWith(showPass: !state.showPass));
  }

  bool checkClause() {
    return state.clause;
  }

  bool checkUserName() {
    if (state.userName == "") {
      emit(state.copyWith(
          errorUserName: LocalizationsUtils.localizations.field_required));
      return false;
    }
    emit(state.copyWith(errorUserName: ""));
    return true;
  }

  bool checkPassword() {
    if (state.password == "") {
      emit(state.copyWith(
          errorPassword: LocalizationsUtils.localizations.field_required));
      return false;
    }
    emit(state.copyWith(errorPassword: ""));
    return true;
  }

  bool checkLogin() {
    return checkUserName() && checkPassword() && checkClause();
  }

  Future<void> login() async {
    if (checkLogin()) {
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
          print("LOGIN RESPONSE SUCCESS: ${response.isSuccess}");
          print("LOGIN RESPONSE ERROR: ${response.error}");
          print("LOGIN RESPONSE DATA: ${response.data}");
          if (response.data?.accessToken != null) {
            sharedPreferences.setAccessToken(response.data!.accessToken);

            emit(state.copyWith(request: Result(status: LoadStatus.success)));
            return;
          }
          emit(state.copyWith(request: Result(status: LoadStatus.failure)));
          return;
        }
        emit(state.copyWith(
            request: Result(status: LoadStatus.failure),
            error: response.error));
        return;
      } on DioException catch (e) {

        print("STATUS CODE = ${e.response?.statusCode}");
        print("RESPONSE DATA = ${e.response?.data}");

        String errorMessage = "Đăng nhập thất bại";

        final statusCode =
            e.response?.statusCode;

        final data =
            e.response?.data;

        if (statusCode == 400 ||
            statusCode == 401) {

          errorMessage =
          "Tên đăng nhập hoặc mật khẩu không chính xác.";

        } else if (data != null &&
            data["error_description"] != null) {

          errorMessage =
              data["error_description"].toString();

        } else if (data != null &&
            data["message"] != null) {

          errorMessage =
              data["message"].toString();

        } else if (data != null &&
            data["error"] != null) {

          errorMessage =
              data["error"].toString();
        }

        print("LOGIN ERROR: $data");

        emit(
          state.copyWith(
            request: Result(
              status: LoadStatus.failure,
            ),
            error: errorMessage,
          ),
        );

        return;

      } catch (e) {

        emit(
          state.copyWith(
            request: Result(
              status: LoadStatus.failure,
            ),
            error:
            "Không thể kết nối máy chủ",
          ),
        );

        return;
      }
    }
  }

  Future<bool> checkToken() async {
    emit(state.copyWith(request: Result(status: LoadStatus.loading)));
    final token = await sharedPreferences.getAccessToken();
    if (token.isNotEmpty) {
      emit(state.copyWith(request: Result(status: LoadStatus.success)));
      return true;
    }
    emit(state.copyWith(request: Result(status: LoadStatus.failure)));
    return false;
  }

  Future<void> loginTest() async {
    try {
      emit(state.copyWith(request: Result(status: LoadStatus.loading)));
      changeRequest();
      final response = await authRepository.signIn(AuthRequest(
          username: useNameTest,
          password: passwordTest,
          grantType: 'password',
          clientId: 'MonitorSystem_App',
          scope: 'MonitorSystem offline_access'));
      if (response.isSuccess) {
        if (response.data?.accessToken != null) {
          sharedPreferences.setAccessToken(response.data!.accessToken);
          print(response.data!.accessToken);
          emit(state.copyWith(request: Result(status: LoadStatus.success)));
          return;
        }
        emit(state.copyWith(request: Result(status: LoadStatus.failure)));
        return;
      }
      emit(state.copyWith(
          request: Result(status: LoadStatus.failure), error: response.error));
      return;
    } catch (e) {
      emit(state.copyWith(
          request: Result(status: LoadStatus.failure),
          error: LocalizationsUtils.localizations.an_error_occurred));
      return;
    }
  }
}
