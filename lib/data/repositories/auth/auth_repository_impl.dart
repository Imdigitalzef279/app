import 'package:dio/dio.dart';
import 'package:solar_energy/data/dto/auth/request/auth_request.dart';
import 'package:solar_energy/data/dto/auth/response/auth_response.dart';
import 'package:solar_energy/data/dto/profile/profile_response.dart';
import 'package:solar_energy/data/dto/result/result.dart';
import 'package:solar_energy/data/repositories/auth/auth_repository.dart';
import 'package:solar_energy/data/repositories/base_repository.dart';

import '../../../di.dart';
import '../../data_sources/api/api_client.dart';

class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  @override
  Future<Result<AuthResponse>> signIn(AuthRequest request) async {
    return await callApi(() => api.signIn(
      request.grantType,
      request.clientId,
      request.username,
      request.password,
      request.scope,
    ));
  }

  @override
  Future<Result<ProfileResponse>> getProfile() async{
    return await callApi(() => api.getProfile());
  }

  @override
  Future<String> deleteAccount(String uid) async {
    final api = getIt.get<ApiClient>();
    try{
      final response = await api.deleteAccount(uid);
      if(response.isNotEmpty){
        return response;
      }
      return "Không tìm thấy user ";
    }catch (e){
      if (e is DioException){
        return e.message.toString();
      }
      return "Lỗi hệ thống vui lòng thao tác lại sau";
    }
  }
}

