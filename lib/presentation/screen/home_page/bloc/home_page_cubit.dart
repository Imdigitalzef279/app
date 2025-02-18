import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solar_energy/application/enums/load_status.dart';
import 'package:solar_energy/data/dto/api_response/api_response.dart';
import 'package:solar_energy/data/dto/project/request/project_request.dart';
import 'package:solar_energy/data/dto/project/response/project_response.dart';
import 'package:solar_energy/data/dto/result/result.dart';
import 'package:solar_energy/data/repositories/project/project_repository.dart';
import 'package:solar_energy/di.dart';

part 'home_page_state.dart';

part 'home_page_cubit.freezed.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageState.init());
  final ProjectRepository _repo = getIt.get<ProjectRepository>();

  Future<void> getProjects() async {
    ProjectRequest request = const ProjectRequest();
    emit(state.copyWith(resultProjects: Result(status: LoadStatus.loading)));
    final response = await _repo.getProjects(request);
    emit(state.copyWith(
        resultProjects: response, request: request.copyWith(skipCount: 1)));
  }

  Future<void> getProjectsMore() async {
    if (state.resultProjects.data != null &&
        state.resultProjects.data!.totalCount <=
            state.resultProjects.data!.data.length) return;
    emit(state.copyWith(resultProjects: Result(status: LoadStatus.loading)));
    final Result<PaginationResponse<ProjectResponse>> response =
        await _repo.getProjects(state.request);
    if (response.data == null) return;
    PaginationResponse<ProjectResponse> pageResponse = PaginationResponse(
        data: [...?state.resultProjects.data?.data, ...response.data!.data]);
    emit(state.copyWith(
        resultProjects: response.copyWith(data: pageResponse),
        request:
            state.request.copyWith(skipCount: state.request.skipCount + 1)));
  }
}
