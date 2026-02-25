import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:solar_energy/application/enums/load_status.dart';
import 'package:solar_energy/data/dto/api_response/api_response.dart';
import 'package:solar_energy/data/dto/atomat/atomat_log_response.dart';
import 'package:solar_energy/data/dto/atomat/atomat_request.dart';
import 'package:solar_energy/data/dto/result/result.dart';
import 'package:solar_energy/data/repositories/atomat_repo/atomat_repository.dart';
import 'package:solar_energy/presentation/common_widgets/app_toast.dart';
import 'package:solar_energy/data/dto/electric/breaker_state_response.dart';
import '../../../../../domain/mcb/repositories/mcb_repository.dart';

part 'atomat_detail_cubit.freezed.dart';
part 'atomat_detail_state.dart';

class AtomatDetailCubit  extends Cubit<AtomatDetailState>{
  AtomatDetailCubit() : super(AtomatDetailState.initial());

  final _repo = GetIt.instance<AtomatRepository>();
  final _mcbRepo = GetIt.instance<McbRepository>();

  Future<void> getLogAtomat(AtomatRequest request) async {
    try {
      emit(state.copyWith(load: LoadStatus.loading));

      final response = await _repo.getLogAtomat(request);

      if (response == null || response.isEmpty) {
        emit(state.copyWith(load: LoadStatus.failure));
        return;
      }

      emit(state.copyWith(
        load: LoadStatus.success,
        logData: response.last,
        logList: response,// LẤY LOG REALTIME
      ));
    } catch (e) {
      emit(state.copyWith(load: LoadStatus.failure));
      AppToast.showToastError(title: "Lỗi!!!");
    }
  }
  Future<void> loadBreakerState({
    required String gatewaySn,
    required String breakerSn,
    required String addr,
  }) async {
    try {
      final result = await _mcbRepo.getBreakerState(
        gatewaySn: gatewaySn,
        breakerSn: breakerSn,
        addr: addr,
      );

      emit(state.copyWith(
        breakerState: result,
      ));
    } catch (e) {
      AppToast.showToastError(title: "Lỗi lấy trạng thái CB");
    }
  }

}