import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:solar_energy/data/dto/api_response/api_response.dart';
import 'package:solar_energy/data/dto/atomat/atomat_log_response.dart';
import 'package:solar_energy/data/dto/atomat/atomat_request.dart';
import 'package:solar_energy/data/dto/auth/response/auth_response.dart';
import 'package:solar_energy/data/dto/cbs/request/cbs_meter_request.dart';
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
import 'package:solar_energy/data/dto/solar_electric/request/solar_electric_request.dart';
import 'package:solar_energy/data/dto/solar_electric/response/solar_electric_response.dart';
import 'package:solar_energy/data/dto/water/request/meter_water_request.dart';
import 'package:solar_energy/data/dto/water/response/meter_water_response.dart';
import 'package:solar_energy/data/dto/meter_config/request/meter_config_request.dart';
import 'package:solar_energy/data/dto/meter_config/response/meter_config_response.dart';

import '../../dto/Price/price_config_response.dart';
import '../../dto/atomat/atomat_chart/breaker_chart_response.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: '')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  // ================= AUTH =================

  @POST('connect/token')
  @FormUrlEncoded()
  Future<AuthResponse> signIn(
      @Field('grant_type') String grantType,
      @Field('client_id') String clientId,
      @Field('username') String username,
      @Field('password') String password,
      @Field('scope') String scope,
      );

  // ================= SOLAR =================

  @GET('api/app/power-station/solar-power-chart')
  Future<PaginationResponse<SolarElectricResponse>> getSolarElectric(
      @Queries() SolarElectricRequest request);

  // ================= ELECTRIC CHART =================

  @GET('api/app/log-meter/history-log-meter-by-group-type')
  Future<PaginationResponse<LastedLogDataResponse>> getChartElectric(
      @Queries() ChartElectricRequest request);

  // ================= REALTIME ELECTRIC DETAIL (QUAN TRỌNG) =================

  @GET('api/app/log-meter/top-log-meter')
  Future<LastedLogDataResponse> getTopLogMeter(
      @Query('meterId') int meterId,
      );

  // ================= DEVICE =================

  @GET('api/app/meter/meter-lookup/{id}')
  Future<List<DeviceResponse>> getDevices(
      @Path("id") int powerStationID,
      );

  @GET('api/app/meter/with-log') /// con này log đồng hồ
  Future<PaginationResponse<ElectricMeter>> getElectric(
      @Query('PowerStationId') int powerStation,
      );

  // ================= PROFILE =================

  @GET('api/account/my-profile')
  Future<ProfileResponse> getProfile();

  @DELETE('api/user/{uid}')
  Future<String> deleteAccount(@Path("uid") uid);

  // ================= POWER STATION =================

  @GET('api/app/power-station/power-station-lookup/{projectId}')
  Future<List<PowerStationResponse>> getPowerStation(
      @Path("projectId") int projectId,
      );

  @POST("api/app/power-station")
  Future<PowerStationResponse> createPowerStation(
      @Body() PowerStationRequest request,
      );

  // ================= METER =================

  @POST("api/app/meter")
  Future<MeterResponse> createMeter(
      @Body() MeterRequest request,
      );

  // ================= WATER =================

  @GET("api/app/log-water/log-by-meter-detail-id")
  Future<List<MeterWaterResponse>> getChartWater(
      @Queries() MeterWaterRequest request,
      );

  // ================= BREAKER CONTROL =================

  @POST("api/app/breaker-command")
  Future<int> controlCircuitBreaker(
      @Body() CbsMeterRequest request,
      );
  // ================= BREAKER MAINTENANCE =================
  @POST("api/app/breaker-command/set-maintenance")
  Future<HttpResponse<dynamic>> setBreakerMaintenance(
      @Body() CbsMeterRequest request,
      );
  // ================= BREAKER log =================
  @GET('api/app/log-meter-breaker')
  Future<PaginationResponse<AtomatLogResponse>> getBreakerLog(
      @Query('breakerSn') String breakerSn,
      );
  // ================= BREAKER chart =================
  @GET('api/app/log-meter-breaker/chart-data')
  Future<List<BreakerChartResponse>> getBreakerChartData(
      @Query('breakerSn') String breakerSn,
      );
  // ================= REGISTER =================

  @POST('api/identity/users')
  Future<ProfileResponse> registerUser(
      @Body() UserRequest request,
      );
  // ================= METER CONFIG =================

  @GET('api/app/meter-config/by-meter-id/{meterId}')
  Future<List<MeterConfigResponse>> getMeterConfigByMeterId(
      @Path('meterId') int meterId,
      );
  // ================= Tính tiền điện =================
  @GET('api/app/price-config/by-meter-id/{meterId}')
  Future<List<PriceConfigResponse>> getPriceConfig(
      @Path('meterId') int meterId,
      );
  @POST('api/app/meter-config')
  Future<MeterConfigResponse> createMeterConfig(
      @Body() MeterConfigRequest request,
      );
}
