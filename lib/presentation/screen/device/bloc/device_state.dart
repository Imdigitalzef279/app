part of 'device_cubit.dart';

@freezed
class DeviceState with _$DeviceState {
  const factory DeviceState({
    required Result<List<DeviceResponse>> resultDevices,

    @Default(LoadStatus.initial)
    LoadStatus status,

    @Default(false)
    bool isForceLoading,
  }) = _DeviceState;

  factory DeviceState.init() => DeviceState(
    resultDevices: Result<List<DeviceResponse>>(),
    status: LoadStatus.initial,
  );
}