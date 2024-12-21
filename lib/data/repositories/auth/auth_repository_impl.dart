import 'package:solar_energy/data/dto/auth/request/auth_request.dart';
import 'package:solar_energy/data/dto/auth/response/auth_response.dart';
import 'package:solar_energy/data/dto/result/result.dart';
import 'package:solar_energy/data/repositories/auth/auth_repository.dart';
import 'package:solar_energy/data/repositories/base_repository.dart';

class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  @override
  Future<Result<AuthResponse>> signIn(AuthRequest request) async {
    return await callApi(() => api.signIn(request));
  }
}
