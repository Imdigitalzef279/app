import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:solar_energy/data/dto/api_response/api_response.dart';
import 'package:solar_energy/data/dto/auth/response/auth_response.dart';
import 'package:solar_energy/data/dto/device/request/device_request.dart';
import 'package:solar_energy/data/dto/device/response/device_response.dart';
import 'package:solar_energy/data/dto/profile/profile_response.dart';
import 'package:solar_energy/data/dto/solar_electric/request/solar_electric_request.dart';
import 'package:solar_energy/data/dto/solar_electric/response/solar_electric_response.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: '')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @POST('connect/token')
  @FormUrlEncoded()
  Future<AuthResponse> signIn(
      @Field('grant_type') String grantType,
      @Field('client_id') String clientId,
      @Field('username') String username,
      @Field('password') String password,
      @Field('scope') String scope,
      );

  @GET('api/app/power-station/solar-power-chart')
  Future<PaginationResponse<SolarElectricResponse>> getSolarElectric(
      @Queries() SolarElectricRequest request);

  @GET('api/app/meter/with-log')
  Future<PaginationResponse<DeviceResponse>> getDevices(
      @Queries() DeviceRequest request);

  @GET('api/account/my-profile')
  Future<ProfileResponse> getProfile();
}
