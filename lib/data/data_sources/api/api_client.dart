import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:solar_energy/data/dto/auth/request/auth_request.dart';
import 'package:solar_energy/data/dto/auth/response/auth_response.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: '')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @POST('/account/login')
  Future<AuthResponse> signIn(@Body() AuthRequest request);
}
