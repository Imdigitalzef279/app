part of 'home_page_cubit.dart';

@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState({
    required Result<List<PowerStationResponse>> resultProjects,
    //required ProjectRequest request,
    @Default(0) int projectID,
    @Default(0) int allStation,
    @Default(0) int active,
    @Default(0) int warning,
    @Default(0) int loss,
  }) = _HomePageState;

  factory HomePageState.init() {
    return HomePageState(resultProjects: Result(), projectID: 0, active: 0,allStation: 0,loss: 0,warning: 0);
  }
}
