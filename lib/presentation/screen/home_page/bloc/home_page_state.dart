part of 'home_page_cubit.dart';

@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState({
    required Result<List<PowerStationResponse>> resultProjects,
    //required ProjectRequest request,
    @Default(0) int projectID,
  }) = _HomePageState;

  factory HomePageState.init() {
    return HomePageState(
        resultProjects: Result());
  }
}
