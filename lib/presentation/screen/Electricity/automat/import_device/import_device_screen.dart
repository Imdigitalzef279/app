import 'package:flutter/material.dart';
import 'package:excel/excel.dart' as ex;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_selector/file_selector.dart';
import 'dart:typed_data';
import '../../../../../data/dto/device/response/device_response.dart';
import '../../../device/bloc/device_cubit.dart';

class ImportDeviceScreen extends StatefulWidget {
  final int powerStationId;

  const ImportDeviceScreen({
    Key? key,
    required this.powerStationId,
  }) : super(key: key);

  @override
  State<ImportDeviceScreen> createState() => _ImportDeviceScreenState();
}

class _ImportDeviceScreenState extends State<ImportDeviceScreen> {

  List<Map<String, dynamic>> preview = [];

  // ================= IMPORT =================
  void importDevices() {
    final cubit = context.read<DeviceCubit>();

    final newDevices = preview.map((e) {
      return DeviceResponse(
        id: DateTime.now().millisecondsSinceEpoch + preview.indexOf(e),

        // giữ field có sẵn
        name: e["name"] ?? "",
        code: e["serial"] ?? "",

        // nhét tạm vào description cho khỏi mất data
        description: '''
Loại: ${e["type"]}
Vị trí: ${e["location"]}
Bảo hành: ${e["warrantyDate"]}
Bảo trì: ${e["maintenanceDate"]}
Nhà CC: ${e["supplier"]}
Công ty: ${e["company"]}
SĐT: ${e["phone"]}
Email: ${e["email"]}
Hãng: ${e["manufacturer"]}
''',

        // map tạm
        serialNumber: e["serial"] ?? "",
        gatewayNumber: e["supplier"] ?? "",
      );
    }).toList();

    cubit.importDevices(newDevices);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Đã import ${newDevices.length} thiết bị")),
    );

    Navigator.pop(context);
  }

  // ================= EXPORT =================
  Future<void> exportDevices() async {
    final devices =
        context.read<DeviceCubit>().state.resultDevices.data ?? [];

    final excel = ex.Excel.createExcel();
    final sheet = excel['Devices'];

    // ===== HEADER =====
    sheet.appendRow([
      ex.TextCellValue("Tên thiết bị"),
      ex.TextCellValue("Loại"),
      ex.TextCellValue("Vị trí"),
      ex.TextCellValue("Ngày lắp"),
      ex.TextCellValue("Bảo hành"),
      ex.TextCellValue("Bảo trì"),
      ex.TextCellValue("Nhà CC"),
      ex.TextCellValue("Công ty"),
      ex.TextCellValue("SĐT"),
      ex.TextCellValue("Email"),
      ex.TextCellValue("Hãng"),
      ex.TextCellValue("Serial"),
    ]);

    // ===== DATA =====
    for (final d in devices) {
      sheet.appendRow([
        ex.TextCellValue(d.name),
        ex.TextCellValue(""),
        ex.TextCellValue(d.description),
        ex.TextCellValue(""),
        ex.TextCellValue(""),
        ex.TextCellValue(""),
        ex.TextCellValue(d.gatewayNumber),
        ex.TextCellValue(""),
        ex.TextCellValue(""),
        ex.TextCellValue(""),
        ex.TextCellValue(""),
        ex.TextCellValue(d.serialNumber),
      ]);
    }

    // ===== EXPORT FILE =====
    final bytes = excel.encode();
    if (bytes == null) return;

    final file = XFile.fromData(
      Uint8List.fromList(bytes),
      name: "devices.xlsx",
      mimeType:
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
    );

    final path = await getSaveLocation(
      suggestedName: "devices.xlsx",
    );

    if (path != null) {
      await file.saveTo(path.path);

      //  feedback cho user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Export thành công")),
      );
    }
  }

  // ================= PICK FILE =================
  Future<void> pickFile() async {

    final file = await openFile(
      acceptedTypeGroups: [
        XTypeGroup(label: 'excel', extensions: ['xlsx'])
      ],
    );

    if (file == null) return;

    final bytes = await file.readAsBytes();
    final excel = ex.Excel.decodeBytes(bytes);

    List<Map<String, dynamic>> temp = [];

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows.skip(1)) {

        final item = {
          "name": row[0]?.value?.toString() ?? "",
          "type": row[1]?.value?.toString() ?? "",
          "location": row[2]?.value?.toString() ?? "",
          "installDate": row[3]?.value?.toString() ?? "",
          "warrantyDate": row[4]?.value?.toString() ?? "",
          "maintenanceDate": row[5]?.value?.toString() ?? "",
          "supplier": row[6]?.value?.toString() ?? "",
          "company": row[7]?.value?.toString() ?? "",
          "phone": row[8]?.value?.toString() ?? "",
          "email": row[9]?.value?.toString() ?? "",
          "manufacturer": row[10]?.value?.toString() ?? "",
          "serial": row[11]?.value?.toString() ?? "",
        };

        if ((item["name"] ?? "").toString().isEmpty) continue;

        temp.add(item);
      }
    }

    setState(() {
      preview = temp;
    });
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Import thiết bị"),
        centerTitle: true,
      ),

      body: Column(
        children: [

          // ===== PICK FILE =====
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: pickFile,
              icon: Icon(Icons.upload_file),
              label: Text("Chọn file Excel"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // ===== PREVIEW HEADER =====
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Preview (${preview.length})",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // ===== LIST =====
          Expanded(
            child: preview.isEmpty
                ? Center(child: Text("Chưa có dữ liệu"))
                : ListView.builder(
              itemCount: preview.length,
              itemBuilder: (_, i) {
                final item = preview[i];

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.green.shade100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // TITLE
                      Row(
                        children: [
                          Icon(Icons.memory, color: Colors.green),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              item["name"],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 8),

                      Text("📦 Loại: ${item["type"]}"),
                      Text("📍 Vị trí: ${item["location"]}"),

                      SizedBox(height: 6),

                      Text("🛠 Bảo trì: ${item["maintenanceDate"]}"),
                      Text("🛡 Bảo hành: ${item["warrantyDate"]}"),

                      SizedBox(height: 6),

                      Text("🏢 Nhà CC: ${item["supplier"]}"),
                      Text("📞 ${item["phone"]}"),

                      SizedBox(height: 6),

                      Text("🔢 Serial: ${item["serial"]}"),
                    ],
                  ),
                );
              },
            ),
          ),

          // ===== BUTTON =====
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [

                Expanded(
                  child: ElevatedButton(
                    onPressed: exportDevices,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                    ),
                    child: Text("Export", style: TextStyle(color: Colors.black)),
                  ),
                ),

                SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton(
                    onPressed: preview.isEmpty ? null : importDevices,
                    child: Text("Import"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}