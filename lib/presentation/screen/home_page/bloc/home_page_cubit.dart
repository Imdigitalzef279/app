import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/application/enums/load_status.dart';
import 'package:solar_energy/data/dto/power_station/response/power_station_response.dart';

import 'package:solar_energy/data/dto/result/result.dart';
import 'package:solar_energy/data/repositories/project/project_repository.dart';
import 'package:solar_energy/di.dart';

import '../../../../data/data_sources/storage/shared_preferences/shared_preferences_helper.dart';

part 'home_page_state.dart';

part 'home_page_cubit.freezed.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageState.init());
  final ProjectRepository _repo = getIt.get<ProjectRepository>();
  final sharedPreferences = GetIt.instance<SharedPreferencesHelper>();

  Future<void> getProjects() async {
    try {
      if (isClosed) return;
      emit(state.copyWith(
        resultProjects: Result(status: LoadStatus.loading),
      ));

      final token = await sharedPreferences.getAccessToken();

      if (isClosed) return;

      if (token.isNotEmpty) {
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        print("TOKEN = $decodedToken");
        print("PROJECT ID RAW = ${decodedToken['ProjectId']}");
        final projectId = decodedToken['ProjectId'];

        if (projectId != null && projectId is List) {
          int id = int.tryParse(projectId[0]) ?? 0;

          final response = await _repo.getPowerStation(id);

          if (isClosed) return;

          if (response.isSuccess) {
            emit(state.copyWith(
              projectID: id,
              resultProjects: Result(
                status: LoadStatus.success,
                data: response.data,
              ),
              allStation: response.data?.length ?? 0,
              active: response.data?.length ?? 0,
            ));
            return;
          }

          emit(state.copyWith(
            resultProjects: Result(
              status: LoadStatus.failure,
              error: LocalizationsUtils.localizations.noSuccess,
            ),
          ));
          return;
        }

        emit(state.copyWith(
          resultProjects: Result(
            status: LoadStatus.empty,
          ),
        ));
        return;
      }

      emit(state.copyWith(
        resultProjects: Result(
          status: LoadStatus.failure,
          error: LocalizationsUtils.localizations.an_error_occurred,
        ),
      ));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
        resultProjects: Result(
          status: LoadStatus.failure,
          error: LocalizationsUtils.localizations.an_error_occurred,
        ),
      ));
    }
  }

  Future<void> refresh() async {
    try {
      emit(state.copyWith(resultProjects: Result(status: LoadStatus.loading)));
    } catch (e) {}
  }
}
