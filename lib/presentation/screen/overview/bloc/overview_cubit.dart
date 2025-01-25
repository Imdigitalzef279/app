import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solar_energy/application/enums/load_status.dart';
import 'package:solar_energy/data/dto/api_response/api_response.dart';
import 'package:solar_energy/data/dto/result/result.dart';
import 'package:solar_energy/data/dto/solar_electric/request/solar_electric_request.dart';
import 'package:solar_energy/data/dto/solar_electric/response/solar_electric_response.dart';
import 'package:solar_energy/data/repositories/solar_electric/solar_electric_repository.dart';
import 'package:solar_energy/di.dart';

part 'overview_state.dart';

part 'overview_cubit.freezed.dart';

class OverviewCubit extends Cubit<OverviewState> {
  OverviewCubit() : super(OverviewState.init());

  final _repo = getIt.get<SolarElectricRepository>();

  Future<void> getSolarElectric(SolarElectricRequest request) async {
    emit(state.copyWith(resultSolar: Result(status: LoadStatus.loading)));
    final response = await _repo.getSolarElectric(request);
    double totalGridPower = 0;
    double totalProductionPower = 0;
    double totalLoadPower = 0;
    double maxGridPower = 0;
    double maxProductionPower = 0;
    response.when(success: (data) {
      if (data?.data == null) return;
      for (SolarElectricResponse solarElectric in data!.data) {
        totalGridPower += solarElectric.gridPower;
        totalProductionPower += solarElectric.productionPower;
        totalLoadPower += solarElectric.loadPower;
        if (maxGridPower < solarElectric.gridPower) {
          maxGridPower = solarElectric.gridPower;
        }
        if (maxProductionPower < solarElectric.productionPower) {
          maxProductionPower = solarElectric.productionPower;
        }
      }
    });
    emit(state.copyWith(
        resultSolar: response,
        totalGridPower: totalGridPower,
        totalLoadPower: totalLoadPower,
        totalProductionPower: totalProductionPower,
        maxGridPower: maxGridPower,
        maxProductionPower: maxProductionPower));
  }
}
