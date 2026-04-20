import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_selector/file_selector.dart';
import '../../../../../data/dto/device/response/device_response.dart';
import '../../../device/bloc/device_cubit.dart';
import 'dart:typed_data';
class ImportDeviceScreen extends StatefulWidget {
  @override
  State<ImportDeviceScreen> createState() => _ImportDeviceScreenState();
}

class _ImportDeviceScreenState extends State<ImportDeviceScreen> {

  List<Map<String, dynamic>> preview = [];
  void importDevices() {

    final cubit = context.read<DeviceCubit>();

    final newDevices = preview.map((e) {
      return DeviceResponse(
        id: DateTime.now().millisecondsSinceEpoch + preview.indexOf(e),
        name: e["name"],
        code: e["code"],
        gatewayNumber: e["gateway"],
      );
    }).toList();

    cubit.importDevices(newDevices);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Đã import ${newDevices.length} thiết bị")),
    );

    Navigator.pop(context);
  }
  Future<void> exportDevices() async {

    final devices = context.read<DeviceCubit>().state.resultDevices.data ?? [];

    var excel = Excel.createExcel();
    Sheet sheet = excel['Sheet1'];

    /// header
    sheet.appendRow([
      TextCellValue("name"),
      TextCellValue("code"),
      TextCellValue("gateway"),
    ]);

    for (var d in devices) {
      sheet.appendRow([
        TextCellValue(d.name ?? ""),
        TextCellValue(d.code ?? ""),
        TextCellValue(d.gatewayNumber ?? ""),
      ]);
    }

    final bytes = excel.encode();

    if (bytes == null) return;

    final file = XFile.fromData(
      Uint8List.fromList(bytes),
      name: "devices.xlsx",
      mimeType: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
    );

    final path = await getSaveLocation(
      suggestedName: "devices.xlsx",
    );

    if (path != null) {
      await file.saveTo(path.path);
    }
  }
  Future<void> pickFile() async {

    final typeGroup = XTypeGroup(
      label: 'excel',
      extensions: ['xlsx'],
    );

    final file = await openFile(acceptedTypeGroups: [typeGroup]);

    if (file == null) return;

    final bytes = await file.readAsBytes();

    final excel = Excel.decodeBytes(bytes);

    List<Map<String, dynamic>> temp = [];

    for (var table in excel.tables.keys) {

      for (var row in excel.tables[table]!.rows.skip(1)) {

        final name = row[0]?.value?.toString() ?? "";
        final code = row[1]?.value?.toString() ?? "";
        final gateway = row[2]?.value?.toString() ?? "";

        if (name.isEmpty || code.isEmpty) continue;

        temp.add({
          "name": name,
          "code": code,
          "gateway": gateway,
        });
      }
    }

    setState(() {
      preview = temp;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Import thiết bị"),
      ),
      body: Column(
        children: [

          ElevatedButton(
            onPressed: pickFile,
            child: const Text("Chọn file Excel"),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Preview (${preview.length})",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: preview.length,
              itemBuilder: (_, i) {

                final item = preview[i];

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: Row(
                    children: [

                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.electrical_services,
                          color: Colors.green,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["name"],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Code: ${item["code"]}",
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),

                      const Icon(Icons.check_circle, color: Colors.green),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [


                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                    ),
                    onPressed: exportDevices,
                    child: const Text(
                      "Export",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),

                const SizedBox(width: 12),


                Expanded(
                  child: ElevatedButton(
                    onPressed: preview.isEmpty ? null : importDevices,
                    child: const Text("Import"),
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
