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

import '../../../../data/data_sources/api/api_client.dart';
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

      final response =
      await GetIt.I<ApiClient>()
          .getProjects(0, 100);

      final items = response["items"] as List;

      for (final p in items) {
        print(
          "PROJECT ID=${p["id"]} "
              "NAME=${p["name"]}",
        );
      }

      final projectId = items.first["id"] as int;

      print("SELECT PROJECT = $projectId");

      final stations =
      await _repo.getPowerStation(projectId);

      print("STATION COUNT = ${stations.data?.length}");
      if (stations.isSuccess) {
        emit(state.copyWith(
          projectID: projectId,
          resultProjects: Result(
            status: LoadStatus.success,
            data: stations.data,
          ),
          allStation: stations.data?.length ?? 0,
          active: stations.data?.length ?? 0,
        ));

        return; // QUAN TRỌNG
      }

      if (isClosed) return;

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
