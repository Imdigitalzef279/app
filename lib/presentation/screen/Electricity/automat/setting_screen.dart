import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  final dynamic device; // GIỮ device như cũ

  const SettingScreen({
    super.key,
    required this.device,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(device.name ?? device.code ?? "Cài đặt"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// ===== THÔNG TIN THIẾT BỊ =====
            Card(
              child: ListTile(
                leading: const Icon(Icons.electrical_services),
                title: Text(device.name ?? device.code ?? ''),
                subtitle:
                Text("Gateway: ${device.gatewayNumber ?? ''}"),
              ),
            ),

            const SizedBox(height: 20),

            /// ===== BẢNG THÔNG SỐ =====
            Expanded(
              child: SingleChildScrollView(
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Table(
                      border: TableBorder.all(
                          color: Colors.grey.shade300),
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(1.2),
                        2: FlexColumnWidth(1.5),
                      },
                      children: [
                        const TableRow(
                          decoration: BoxDecoration(
                              color: Color(0xFFF0F0F0)),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text("Thông số",
                                  style: TextStyle(
                                      fontWeight:
                                      FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text("Mặc định",
                                  style: TextStyle(
                                      fontWeight:
                                      FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text("Người dùng",
                                  style: TextStyle(
                                      fontWeight:
                                      FontWeight.bold)),
                            ),
                          ],
                        ),

                        _buildRow("Quá dòng (A)", "63", "10", "100"),
                        _buildRow("Quá áp (V)", "240", "200", "260"),
                        _buildRow("Thấp áp (V)", "180", "150", "210"),
                        _buildRow("Dòng dò (mA)", "30", "10", "100"),
                        _buildRow("Quá công suất (kW)", "5", "1", "10"),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// ===== SAVE BUTTON =====
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: giữ logic save cũ
                },
                child: const Text(
                  "Lưu cài đặt",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  static TableRow _buildRow(
      String name, String defaultValue, String min, String max) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(name),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            defaultValue,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.blue,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  hintText: "Nhập giá trị",
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Min: $min | Max: $max",
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}