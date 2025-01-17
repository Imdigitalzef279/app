part of 'detail_factory_cubit.dart';

@freezed
class DetailFactoryState with _$DetailFactoryState {
  const factory DetailFactoryState(
      {required Result<PaginationResponse<SolarElectricResponse>>
          resultSolar}) = _DetailFactoryState;

  factory DetailFactoryState.init() =>
      DetailFactoryState(resultSolar: Result());
}
