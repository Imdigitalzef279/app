import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:solar_energy/application/enums/load_status.dart';
import 'package:solar_energy/data/dto/profile/profile_response.dart';
import 'package:solar_energy/data/dto/register/request/user_request.dart';
import 'package:solar_energy/data/dto/result/result.dart';
import 'package:solar_energy/data/repositories/base_repository.dart';
import 'package:solar_energy/data/repositories/register/register_repository.dart';

import '../../data_sources/api/api_client.dart';
import '../../dto/api_response/api_response.dart';

class RegisterRepositoryImpl extends BaseRepository
    implements RegisterRepository {
  final _api = GetIt.instance<ApiClient>();

  @override
  Future<Result<ProfileResponse>> register(UserRequest request) async {
    final result = Result<ProfileResponse>();
    try {
      final profileResponse = await _api.registerUser(request);
      if(profileResponse.surname.isNotEmpty){
      return result.copyWith(status: LoadStatus.success);}
      return result.copyWith(
          status: LoadStatus.failure,
          error: "Có lỗi xảy ra, vui lòng thao tác lại!!!");
    } catch (e) {
      if (e is DioException && e.error is ErrorResponse) {
        final error = e.error as ErrorResponse;
        return result.copyWith(
            status: LoadStatus.failure, error: error.message);
      }
      return result.copyWith(
          status: LoadStatus.failure,
          error: "Có lỗi xảy ra, vui lòng thao tác lại!!!");
    }
  }
}
