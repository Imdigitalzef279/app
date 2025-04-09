import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solar_energy/application/enums/load_status.dart';
import 'package:solar_energy/data/dto/api_response/api_response.dart';
import 'package:solar_energy/data/dto/device/request/device_request.dart';
import 'package:solar_energy/data/dto/device/response/device_response.dart';
import 'package:solar_energy/data/dto/result/result.dart';
import 'package:solar_energy/data/repositories/device/device_repository.dart';
import 'package:solar_energy/di.dart';

part 'device_state.dart';

part 'device_cubit.freezed.dart';

class DeviceCubit extends Cubit<DeviceState> {
  DeviceCubit() : super(DeviceState.init());

  final _repo = getIt.get<DeviceRepository>();

  Future<void> getDevices({required int powerStationId}) async {
    emit(state.copyWith(resultDevices: Result(status: LoadStatus.loading)));
    final response = await _repo.getSolarElectric(powerStationId);
    emit(state.copyWith(resultDevices: response));
  }
}
