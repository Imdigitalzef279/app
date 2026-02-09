// import 'package:flutter/material.dart';
// import 'model/automat_ui_model.dart';
//
// class AutomatCard extends StatelessWidget {
//   final AutomatUiModel automat;
//   final VoidCallback onTap;
//
//   const AutomatCard({
//     super.key,
//     required this.automat,
//     required this.onTap,
//   });
//
//   Color getStatusColor() {
//     switch (automat.status) {
//       case AutomatStatus.trip:
//         return Colors.red;
//       case AutomatStatus.warning:
//         return Colors.orange;
//       case AutomatStatus.normal:
//       default:
//         return Colors.green;
//     }
//   }
//
//   String getStatusText() {
//     switch (automat.status) {
//       case AutomatStatus.trip:
//         return 'TRIP';
//       case AutomatStatus.warning:
//         return 'Cảnh báo';
//       case AutomatStatus.normal:
//       default:
//         return 'Đang đóng';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(12),
//         onTap: onTap,
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     '${automat.name} | ${automat.type}',
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 10,
//                       vertical: 4,
//                     ),
//                     decoration: BoxDecoration(
//                       color: getStatusColor().withOpacity(0.15),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       getStatusText(),
//                       style: TextStyle(
//                         color: getStatusColor(),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 12),
//
//               // Quick info
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('I: ${automat.current.toStringAsFixed(1)} A'),
//                   Text('P: ${automat.power.toStringAsFixed(1)} kW'),
//                   Text('Load: ${automat.loadPercent.toStringAsFixed(0)}%'),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
