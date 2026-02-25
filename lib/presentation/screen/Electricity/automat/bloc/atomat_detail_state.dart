
part of 'atomat_detail_cubit.dart';

@freezed
class AtomatDetailState with _$AtomatDetailState {
  const factory AtomatDetailState({
    @Default(LoadStatus.initial) LoadStatus load,
    AtomatLogResponse? logData,
    List<AtomatLogResponse>? logList,
    BreakerStateResponse? breakerState,

  }) = _AtomatDetailState;

  factory AtomatDetailState.initial() => const AtomatDetailState();
}