part of 'manager_water_cubit.dart';

@freezed
class ManagerWaterState with _$ManagerWaterState {
  const factory ManagerWaterState(
      {@Default(false) bool isEdit,
      @Default([]) List<WaterIndexModel> listSelected,
      @Default([]) List<WaterIndexModel> listWaterIndex}) = _ManagerWaterState;

  factory ManagerWaterState.init() =>
      ManagerWaterState(isEdit: false, listWaterIndex: [], listSelected: [
        WaterIndexModel(
            icon: Assets.icons.bacteria.path,
            title: "Sinh học",
            unit: "wH",
            value: 25,
            limit: 20,
            isConnected: true),
        WaterIndexModel(
            icon: Assets.icons.flask.path,
            title: "Khí độc",
            unit: "wH",
            value: 45.5,
            limit: 100,
            isConnected: true),
        WaterIndexModel(
            icon: Assets.icons.physics.path,
            title: "Vật lý",
            unit: "wH",
            value: 8,
            limit: 10,
            isConnected: true),
        WaterIndexModel(
            icon: Assets.icons.flaskGear.path,
            title: "Hóa lý đặc biệt",
            unit: "wH",
            value: 5.23,
            limit: 20,
            isConnected: false),
      ]);
}
