import '../../../domain/mcb/entities/mcb_entity.dart';


class McbMockDatasource {
  Future<McbEntity> getDetail(String deviceId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return McbEntity(
      id: deviceId,
      name: 'ACB Tổng MSB1',
      isOnline: true,
      ratedCurrent: 3000,
      current: 1200,
      phaseVoltage: [231.0, 229.0, 230.0],
      phaseCurrent: [62.0, 64.0, 58.0],
      power: 253.36,
      energy: 2533.6,
    );

  }

}
