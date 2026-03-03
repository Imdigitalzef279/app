// import 'package:flutter/material.dart';
//
// class ProtectionSettingScreen extends StatefulWidget {
//   final String deviceId;
//
//   const ProtectionSettingScreen({super.key, required this.deviceId});
//
//   @override
//   State<ProtectionSettingScreen> createState() =>
//       _ProtectionSettingScreenState();
// }
//
// class _ProtectionSettingScreenState
//     extends State<ProtectionSettingScreen> {
//
//   final _formKey = GlobalKey<FormState>();
//
//   final _overCurrentController = TextEditingController();
//   final _overVoltageController = TextEditingController();
//
//   bool _autoTrip = false;
//   bool _notifyApp = true;
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadFakeData();
//   }
//
//   void _loadFakeData() async {
//     setState(() => _isLoading = true);
//
//     await Future.delayed(const Duration(milliseconds: 500));
//
//     _overCurrentController.text = "50";
//     _overVoltageController.text = "240";
//     _autoTrip = true;
//     _notifyApp = true;
//
//     setState(() => _isLoading = false);
//   }
//
//   void _save() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() => _isLoading = true);
//
//     await Future.delayed(const Duration(milliseconds: 500));
//
//     setState(() => _isLoading = false);
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Lưu thành công")),
//     );
//
//     Navigator.pop(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     const primaryColor = Color(0xFF1ABC9C);
//     const bgColor = Color(0xFFF4F7F8);
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFF3F6FB),
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: bgColor,
//         foregroundColor: Colors.black,
//         title: const Text(
//           "Cài đặt bảo vệ",
//           style: TextStyle(fontWeight: FontWeight.w600),
//         ),
//         centerTitle: true,
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Padding(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//
//               /// ===== QUÁ DÒNG =====
//               _buildCard(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Bảo vệ quá dòng",
//                       style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600),
//                     ),
//                     const SizedBox(height: 12),
//                     TextFormField(
//                       controller: _overCurrentController,
//                       keyboardType: TextInputType.number,
//                       decoration: _inputDecoration(
//                           "Ngưỡng quá dòng (A)"),
//                       validator: _validateNumber,
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 16),
//
//               /// ===== QUÁ ÁP =====
//               _buildCard(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Bảo vệ quá áp",
//                       style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600),
//                     ),
//                     const SizedBox(height: 12),
//                     TextFormField(
//                       controller: _overVoltageController,
//                       keyboardType: TextInputType.number,
//                       decoration:
//                       _inputDecoration("Ngưỡng quá áp (V)"),
//                       validator: _validateNumber,
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 16),
//
//               /// ===== SWITCH =====
//               _buildCard(
//                 child: Column(
//                   children: [
//                     SwitchListTile(
//                       contentPadding: EdgeInsets.zero,
//                       title: const Text(
//                           "Tự động ngắt khi vượt ngưỡng"),
//                       value: _autoTrip,
//                       activeColor: primaryColor,
//                       onChanged: (v) =>
//                           setState(() => _autoTrip = v),
//                     ),
//                     const Divider(height: 1),
//                     SwitchListTile(
//                       contentPadding: EdgeInsets.zero,
//                       title:
//                       const Text("Cảnh báo qua App"),
//                       value: _notifyApp,
//                       activeColor: primaryColor,
//                       onChanged: (v) =>
//                           setState(() => _notifyApp = v),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 32),
//
//               /// ===== BUTTON =====
//               SizedBox(
//                 height: 50,
//                 child: DecoratedBox(
//                   decoration: BoxDecoration(
//                     borderRadius:
//                     BorderRadius.circular(30),
//                     gradient: const LinearGradient(
//                       colors: [
//                         Color(0xFF1ABC9C),
//                         Color(0xFF16A085),
//                       ],
//                     ),
//                   ),
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:
//                       Colors.transparent,
//                       shadowColor:
//                       Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius:
//                         BorderRadius.circular(30),
//                       ),
//                     ),
//                     onPressed: _save,
//                     child: const Text(
//                       "Lưu thay đổi",
//                       style: TextStyle(
//                           fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCard({required Widget child}) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           )
//         ],
//       ),
//       child: child,
//     );
//   }
//
//   InputDecoration _inputDecoration(String label) {
//     return InputDecoration(
//       labelText: label,
//       filled: true,
//       fillColor: const Color(0xFFF4F7F8),
//       contentPadding:
//       const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide.none,
//       ),
//     );
//   }
//
//   String? _validateNumber(String? value) {
//     if (value == null || value.isEmpty) {
//       return "Vui lòng nhập giá trị";
//     }
//     final v = double.tryParse(value);
//     if (v == null || v <= 0) {
//       return "Giá trị không hợp lệ";
//     }
//     return null;
//   }
// }