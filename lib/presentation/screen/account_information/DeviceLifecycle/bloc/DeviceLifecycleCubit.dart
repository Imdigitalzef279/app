import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../data/dto/device/response/device_response.dart';
import '../../../../../data/repositories/device/device_repository.dart';
import '../../../../../di.dart';

import 'DeviceLifecycleState.dart';

class DeviceLifecycleCubit
    extends Cubit<DeviceLifecycleState> {

  DeviceLifecycleCubit()
      : super(const DeviceLifecycleState());

  final _repo = getIt<DeviceRepository>();

  Future<void> loadDevices(
      List<int> stationIds,
      ) async {

    emit(
      state.copyWith(
        loading: true,
      ),
    );

    List<DeviceResponse> allDevices = [];

    for (final stationId in stationIds) {

      final response =
      await _repo.getSolarElectric(
        stationId,
      );

      if (response.data != null) {
        allDevices.addAll(response.data!);
      }
    }

    emit(
      state.copyWith(
        loading: false,
        devices: allDevices,
      ),
    );
  }
}