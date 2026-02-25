// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'protection_setting_cubit.dart';
//
// class ProtectionSettingScreen extends StatelessWidget {
//   final String deviceId;
//
//   const ProtectionSettingScreen({super.key, required this.deviceId});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => ProtectionSettingCubit()..load(deviceId),
//       child: const _ProtectionSettingView(),
//     );
//   }
// }
// class _ProtectionSettingView extends StatefulWidget {
//   const _ProtectionSettingView();
//
//   @override
//   State<_ProtectionSettingView> createState() =>
//       _ProtectionSettingViewState();
// }
//
// class _ProtectionSettingViewState extends State<_ProtectionSettingView> {
//   final _formKey = GlobalKey<FormState>();
//
//   final _overCurrentController = TextEditingController();
//   final _overVoltageController = TextEditingController();
//
//   bool _autoTrip = false;
//   bool _notifyApp = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Cài đặt bảo vệ"),
//       ),
//       body: BlocConsumer<ProtectionSettingCubit, ProtectionSettingState>(
//         listener: (context, state) {
//           if (state is ProtectionSaved) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text("Lưu thành công")),
//             );
//             Navigator.pop(context);
//           }
//         },
//         builder: (context, state) {
//           if (state is ProtectionLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (state is ProtectionLoaded) {
//             _overCurrentController.text =
//                 state.model.overCurrentThreshold.toString();
//             _overVoltageController.text =
//                 state.model.overVoltageThreshold.toString();
//             _autoTrip = state.model.autoTrip;
//             _notifyApp = state.model.notifyApp;
//           }
//
//           return Padding(
//             padding: const EdgeInsets.all(16),
//             child: Form(
//               key: _formKey,
//               child: ListView(
//                 children: [
//                   const Text("Bảo vệ quá dòng",
//                       style:
//                       TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 8),
//
//                   /// Over Current
//                   TextFormField(
//                     controller: _overCurrentController,
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(
//                       labelText: "Ngưỡng quá dòng (A)",
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Vui lòng nhập ngưỡng";
//                       }
//                       final v = double.tryParse(value);
//                       if (v == null || v <= 0) {
//                         return "Giá trị không hợp lệ";
//                       }
//                       return null;
//                     },
//                   ),
//
//                   const SizedBox(height: 24),
//
//                   /// Over Voltage
//                   const Text("Bảo vệ quá áp",
//                       style:
//                       TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 8),
//
//                   TextFormField(
//                     controller: _overVoltageController,
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(
//                       labelText: "Ngưỡng quá áp (V)",
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Vui lòng nhập ngưỡng";
//                       }
//                       final v = double.tryParse(value);
//                       if (v == null || v <= 0) {
//                         return "Giá trị không hợp lệ";
//                       }
//                       return null;
//                     },
//                   ),
//
//                   const SizedBox(height: 24),
//
//                   /// Auto trip
//                   SwitchListTile(
//                     title: const Text("Tự động ngắt khi vượt ngưỡng"),
//                     value: _autoTrip,
//                     onChanged: (v) => setState(() => _autoTrip = v),
//                   ),
//
//                   /// Notify
//                   SwitchListTile(
//                     title: const Text("Cảnh báo qua App"),
//                     value: _notifyApp,
//                     onChanged: (v) => setState(() => _notifyApp = v),
//                   ),
//
//                   const SizedBox(height: 24),
//
//                   ElevatedButton(
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         context.read<ProtectionSettingCubit>().save(
//                           overCurrent:
//                           double.parse(_overCurrentController.text),
//                           overVoltage:
//                           double.parse(_overVoltageController.text),
//                           autoTrip: _autoTrip,
//                           notifyApp: _notifyApp,
//                         );
//                       }
//                     },
//                     child: const Text("Lưu cấu hình"),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }