// import 'package:flutter/cupertino.dart';
//
// import '../../../domain/mcb/entities/chart_data_entity.dart';
// import '../../../domain/mcb/entities/mcb_entity.dart';
// import 'mcb_mock_datasource.dart';
//
// class McbRealtimeMockDatasource {
//   Future<McbEntity> getRealtime(String deviceId) async {
//     await Future.delayed(const Duration(milliseconds: 300));
//     return McbMockDatasource().getDetail(deviceId);
//   }
//   Future<List<ChartDataEntity>> getHistory(String type) async {
//     await Future.delayed(const Duration(milliseconds: 300));
//     return List.generate(
//       24,
//           (i) => ChartDataEntity(
//         time: DateTime.now().subtract(Duration(hours: 24 - i)),
//         value: (i * 3 + 10).toDouble(),
//         phase: 'A',
//       ),
//     );
//   }
//
//   Future<void> control(String deviceId, String action) async {
//     await Future.delayed(const Duration(milliseconds: 300));
//     debugPrint('Mock control: $deviceId -> $action');
//   }
// }
//   Future<List<ChartDataEntity>> getHistory(String type) async {
//     await Future.delayed(const Duration(milliseconds: 300));
//
//     return List.generate(24, (i) {
//       return ChartDataEntity(
//         time: DateTime.now().subtract(Duration(hours: 24 - i)),
//         value: (i * 3 + 10).toDouble(),
//         phase: 'A',
//       );
//     });
//   }
//
//   Future<void> control(String deviceId, String action) async {
//     await Future.delayed(const Duration(milliseconds: 200));
//   }
// }
