import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:solar_energy/application/enums/load_status.dart';
import 'package:solar_energy/data/dto/profile/profile_response.dart';
import 'package:solar_energy/data/dto/register/request/user_request.dart';
import 'package:solar_energy/data/dto/result/result.dart';
import 'package:solar_energy/data/repositories/base_repository.dart';
import 'package:solar_energy/data/repositories/register/register_repository.dart';

import '../../data_sources/api/api_client.dart';

import '../../dto/register_account/request/register_account_request.dart';

class RegisterRepositoryImpl extends BaseRepository
    implements RegisterRepository {
  final _api = GetIt.instance<ApiClient>();

  @override
  Future<Result<ProfileResponse>> register(UserRequest request) async {
    final result = Result<ProfileResponse>();
    try {
      await _api.registerAccount(
        RegisterAccountRequest(
          userName: request.userName,
          emailAddress: request.email,
          password: request.password,
          appName: "KraPower",
        ),
      );

      return result.copyWith(
        status: LoadStatus.success,
      );

    } catch (e) {
      print("============== REGISTER ERROR ==============");
      print(e);

      if (e is DioException) {
        print("STATUS CODE: ${e.response?.statusCode}");
        print("RESPONSE: ${e.response?.data}");
      }

      return result.copyWith(
        status: LoadStatus.failure,
        error: e.toString(),
      );
    }
  }
}
