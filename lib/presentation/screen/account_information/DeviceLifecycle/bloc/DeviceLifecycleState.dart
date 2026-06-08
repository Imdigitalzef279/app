import 'package:solar_energy/data/dto/device/response/device_response.dart';

class DeviceLifecycleState {
  final bool loading;
  final List<DeviceResponse> devices;

  const DeviceLifecycleState({
    this.loading = false,
    this.devices = const [],
  });

  DeviceLifecycleState copyWith({
    bool? loading,
    List<DeviceResponse>? devices,
  }) {
    return DeviceLifecycleState(
      loading: loading ?? this.loading,
      devices: devices ?? this.devices,
    );
  }
}