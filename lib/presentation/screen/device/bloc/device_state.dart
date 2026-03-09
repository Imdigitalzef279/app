part of 'device_cubit.dart';

@freezed
class DeviceState with _$DeviceState {
  const factory DeviceState({

    required Result<List<DeviceResponse>> resultDevices,

    @Default(LoadStatus.initial)
    LoadStatus status,

    /// loading cho FORCE
    @Default(false)
    bool isForceLoading,

    /// loading cho ON/OFF
    @Default(false)
    bool isSwitching,

    /// countdown cho breaker
    @Default(0)
    int switchCountdown,

    AtomatLogResponse? breakerLog,

  }) = _DeviceState;

  factory DeviceState.init() => DeviceState(
    resultDevices: Result<List<DeviceResponse>>(),
    status: LoadStatus.initial,
  );
}