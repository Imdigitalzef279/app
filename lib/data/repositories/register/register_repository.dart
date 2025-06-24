import 'package:solar_energy/data/dto/profile/profile_response.dart';
import 'package:solar_energy/data/dto/register/request/user_request.dart';
import 'package:solar_energy/data/dto/result/result.dart';

abstract class RegisterRepository {
  Future<Result<ProfileResponse>> register(UserRequest request);
}