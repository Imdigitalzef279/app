import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solar_energy/data/dto/api_response/api_response.dart';
import 'package:solar_energy/data/dto/result/result.dart';
import 'package:solar_energy/data/dto/solar_electric/request/solar_electric_request.dart';
import 'package:solar_energy/data/dto/solar_electric/response/solar_electric_response.dart';
import 'package:solar_energy/data/repositories/solar_electric/solar_electric_repository.dart';
import 'package:solar_energy/di.dart';

part 'detail_factory_state.dart';

part 'detail_factory_cubit.freezed.dart';

class DetailFactoryCubit extends Cubit<DetailFactoryState> {
  DetailFactoryCubit() : super(DetailFactoryState.init());

  final _repo = getIt.get<SolarElectricRepository>();

  Future<void> getSolarElectric(SolarElectricRequest request) async {
    final response = await _repo.getSolarElectric(request);
    emit(state.copyWith(resultSolar: response));
  }
}
