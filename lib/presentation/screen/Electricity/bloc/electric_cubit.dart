import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:solar_energy/application/enums/load_status.dart';
import 'package:solar_energy/data/repositories/electric/electric_repository.dart';

import '../../../../data/data_sources/storage/shared_preferences/shared_preferences_helper.dart';
import '../../../../data/dto/electric/response/electric_meter_response.dart';
import '../../../../data/dto/result/result.dart';

part 'electric_cubit.freezed.dart';

part 'electric_state.dart';

class ElectricCubit extends Cubit<ElectricState> {
  ElectricCubit() : super(ElectricState.initial());

  final electricRepository = GetIt.instance<ElectricRepository>();
  final sharedPreferences = GetIt.instance<SharedPreferencesHelper>();

  Future<void> getElectric(int projectId) async {
    try {
      emit(state.copyWith(
          response: Result(status: LoadStatus.loading),
          loadStatus: LoadStatus.loading));
      final response = await electricRepository.getElectric(projectId);
      if (response.isSuccess && response.data != null) {
        emit(state.copyWith(
            response: Result(
                status: LoadStatus.success, data: response.data!.data.first),
            loadStatus: LoadStatus.success));

        return;
      }
      emit(state.copyWith(
          response: Result(
            status: LoadStatus.failure,
          ),
          loadStatus: LoadStatus.failure));
      return;
    } catch (e) {
      emit(state.copyWith(
          response: Result(
            status: LoadStatus.failure,
          ),
          loadStatus: LoadStatus.failure));
    }
  }
}
