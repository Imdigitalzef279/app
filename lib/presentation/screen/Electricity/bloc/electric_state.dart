part of 'electric_cubit.dart';


@freezed
class ElectricState with _$ElectricState {
  const factory ElectricState({
    required Result<ElectricMeter> response,
    @Default(LoadStatus.initial) LoadStatus loadStatus,
  }) = _ElectricState;

  factory ElectricState.initial() => ElectricState(
      response: Result(
          data: const ElectricMeter(), status: LoadStatus.initial));
}
