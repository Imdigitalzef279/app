part of 'home_page_cubit.dart';

@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState(
      {required Result<PaginationResponse<ProjectResponse>>
          resultProjects,required ProjectRequest request}) = _HomePageState;

  factory HomePageState.init() {
    return HomePageState(resultProjects: Result(),request:  const ProjectRequest());
  }
}
