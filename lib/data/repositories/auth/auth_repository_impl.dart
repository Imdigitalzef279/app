import 'package:dio/dio.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/data/dto/auth/request/auth_request.dart';
import 'package:solar_energy/data/dto/auth/response/auth_response.dart';
import 'package:solar_energy/data/dto/profile/profile_response.dart';
import 'package:solar_energy/data/dto/result/result.dart';
import 'package:solar_energy/data/repositories/auth/auth_repository.dart';
import 'package:solar_energy/data/repositories/base_repository.dart';

import '../../../di.dart';
import '../../data_sources/api/api_client.dart';
class AuthRepositoryImpl extends BaseRepository implements AuthRepository {

  ProfileResponse? currentProfile;
  @override
  Future<Result<AuthResponse>> signIn(AuthRequest request) async {
    return await callApi(() => api
        .signIn(
          request.grantType,
          request.clientId,
          request.username,
          request.password,
          request.scope,
        )
        .timeout(const Duration(seconds: 15)));
  }

  @override
  Future<Result<ProfileResponse>> getProfile() async {
    final result = await callApi(() => api.getProfile());

    result.when(
      success: (profile) {
        currentProfile = profile;
      },
      error: (_) {},
    );

    return result;
  }

  @override
  Future<String> deleteAccount(String uid) async {
    final api = getIt.get<ApiClient>();
    try {
      final response =
          await api.deleteAccount(uid).timeout(const Duration(seconds: 15));
      if (response.isNotEmpty) {
        return response;
      }
      return LocalizationsUtils.localizations.user_not_found;
    } catch (e) {
      if (e is DioException) {
        return e.message.toString();
      }
      return LocalizationsUtils.localizations.an_error_occurred;
    }
  }
}
