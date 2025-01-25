part of 'device_cubit.dart';

@freezed
class DeviceState with _$DeviceState {
  const factory DeviceState(
          {required Result<PaginationResponse<DeviceResponse>> resultDevices}) =
      _DeviceState;

  factory DeviceState.init() => DeviceState(resultDevices: Result());
}
