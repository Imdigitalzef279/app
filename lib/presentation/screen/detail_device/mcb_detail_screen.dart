// import 'package:flutter/material.dart';
// import 'package:solar_energy/presentation/screen/detail_device/widgets/mcb_alarm_section.dart';
// import '../../../data/data_sources/mcb/mcb_mock_datasource.dart';
// import '../../../data/data_sources/mcb/mcb_remote_datasource.dart';
// import '../../../data/repositories/mcb_repository_impl.dart';
// import '../../../domain/mcb/entities/mcb_entity.dart';
// import 'widgets/mcb_header.dart';
// import 'widgets/mcb_status_bar.dart';
// import 'widgets/mcb_control_panel.dart';
// import 'widgets/mcb_realtime_cards.dart';
// import 'widgets/mcb_chart_section.dart';
//
// class McbDetailScreen extends StatelessWidget {
//   final String deviceId;
//   const McbDetailScreen({super.key, required this.deviceId});
//
//   @override
//   Widget build(BuildContext context) {
//     final repo = McbRepositoryImpl(
//       mock: McbMockDatasource(),
//       remote: McbRemoteDatasource(http.Client()),
//     );
//
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('Chi tiết ACB / MCCB')),
//       body: FutureBuilder<McbEntity>(
//         future: repo.getDetail(deviceId),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           final mcb = snapshot.data!;
//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 McbHeader(mcb: mcb),
//                 const SizedBox(height: 12),
//                 McbStatusBar(mcb: mcb),
//                 const SizedBox(height: 12),
//                 McbControlPanel(mcb: mcb),
//                 const SizedBox(height: 12),
//                 McbRealtimeCards(mcb: mcb),
//                 const SizedBox(height: 12),
//                 McbChartSection(title: 'Phase current'),
//                 McbChartSection(title: 'Phase voltage'),
//                 McbChartSection(title: 'Leakage & Temperature'),
//                 const SizedBox(height: 12),
//                 McbAlarmSection(deviceId: mcb.id),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
