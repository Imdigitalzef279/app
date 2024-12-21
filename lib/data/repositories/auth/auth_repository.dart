import 'package:solar_energy/data/dto/auth/request/auth_request.dart';
import 'package:solar_energy/data/dto/auth/response/auth_response.dart';
import 'package:solar_energy/data/dto/result/result.dart';

abstract class AuthRepository {
  Future<Result<AuthResponse>> signIn(AuthRequest request);
}
