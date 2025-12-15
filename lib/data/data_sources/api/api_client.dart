import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:solar_energy/data/dto/api_response/api_response.dart';
import 'package:solar_energy/data/dto/auth/response/auth_response.dart';
import 'package:solar_energy/data/dto/cbs/request/cbs_meter_request.dart';
import 'package:solar_energy/data/dto/device/request/device_request.dart';
import 'package:solar_energy/data/dto/device/response/device_response.dart';
import 'package:solar_energy/data/dto/electric/chart_electric/chart_electric_request.dart';
import 'package:solar_energy/data/dto/electric/response/electric_meter_response.dart';
import 'package:solar_energy/data/dto/lasted_log_data/response/lasted_log_data_response.dart';
import 'package:solar_energy/data/dto/meter/request/meter_request.dart';
import 'package:solar_energy/data/dto/meter/response/meter_response.dart';
import 'package:solar_energy/data/dto/power_station/request/power_station_request.dart';
import 'package:solar_energy/data/dto/power_station/response/power_station_response.dart';
import 'package:solar_energy/data/dto/profile/profile_response.dart';
import 'package:solar_energy/data/dto/register/request/user_request.dart';
import 'package:solar_energy/data/dto/result/result.dart';
import 'package:solar_energy/data/dto/solar_electric/request/solar_electric_request.dart';
import 'package:solar_energy/data/dto/solar_electric/response/solar_electric_response.dart';
import 'package:solar_energy/data/dto/water/request/meter_water_request.dart';
import 'package:solar_energy/data/dto/water/response/meter_water_response.dart';

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

  @GET('api/app/log-meter/history-log-meter-by-group-type')
  Future<PaginationResponse<LastedLogDataResponse>> getChartElectric(
      @Queries() ChartElectricRequest request);

  @GET('api/app/meter/meter-lookup/{id}')
  Future<List<DeviceResponse>> getDevices(@Path("id") int powerStationID);

  @GET('api/account/my-profile')
  Future<ProfileResponse> getProfile();

  @DELETE('api/user/{uid}')
  Future<String> deleteAccount(@Path("uid") uid);

  @GET('api/app/power-station/power-station-lookup/{projectId}')
  Future<List<PowerStationResponse>> getPowerStation(
    @Path("projectId") int projectId,
  );

  @GET('api/app/meter/with-log')
  Future<PaginationResponse<ElectricMeter>> getElectric(
    @Query('ProjectId') int projectId,
  );

  @POST('api/identity/users')
  Future<ProfileResponse> registerUser(
    @Body() UserRequest request,
  );

  @POST("api/app/power-station")
  Future<PowerStationResponse> createPowerStation(
      @Body() PowerStationRequest request);

  @POST("api/app/meter")
  Future<MeterResponse> createMeter(@Body() MeterRequest request);

  @GET("api/app/log-water/log-by-meter-detail-id")
  Future<List<MeterWaterResponse>> getChartWater(
      @Queries() MeterWaterRequest request);

  @POST("cbs/api/set")
  Future<String> controlCircuitBreaker (
      @Body() CbsMeterRequest request);
}
