import 'package:flutter/material.dart';
import '../../../data/dto/power_station/response/power_station_response.dart';

enum AccountType {
  admin,
  technician,
  user,
  webPaid,
  appFree,
}

class ProjectSettingScreen extends StatefulWidget {
  final PowerStationResponse project;

  const ProjectSettingScreen({super.key, required this.project});

  @override
  State<ProjectSettingScreen> createState() =>
      _ProjectSettingScreenState();
}

class _ProjectSettingScreenState extends State<ProjectSettingScreen> {
  late TextEditingController nameController;

  AccountType selectedType = AccountType.user;

  bool isLoading = false;

  Map<String, bool> permissions = {
    "view": true,
    "config": false,
    "control": false,
    "report": false,
    "addDevice": false,
  };

  @override
  void initState() {
    super.initState();
    nameController =
        TextEditingController(text: widget.project.name);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  String _mapAccountType(AccountType type) {
    switch (type) {
      case AccountType.admin:
        return "Admin";
      case AccountType.technician:
        return "Kỹ thuật";
      case AccountType.user:
        return "Người dùng thường";
      case AccountType.webPaid:
        return "Tài khoản trả phí Web";
      case AccountType.appFree:
        return "Tài khoản miễn phí App";
    }
  }

  String _mapPermission(String key) {
    switch (key) {
      case "view":
        return "Xem dữ liệu";
      case "config":
        return "Cài đặt thông số";
      case "control":
        return "Đóng cắt thiết bị";
      case "report":
        return "Xuất báo cáo";
      case "addDevice":
        return "Thêm thiết bị";
      default:
        return key;
    }
  }

  void _handleAccountTypeChange(AccountType type) {
    setState(() {
      selectedType = type;

      if (type == AccountType.admin) {
        permissions.updateAll((key, value) => true);
      } else if (type == AccountType.user) {
        permissions.updateAll((key, value) => false);
        permissions["view"] = true;
      }
    });
  }

  Future<void> _handleSave() async {
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tên nhà máy không được để trống")),
      );
      return;
    }

    setState(() => isLoading = true);

    await Future.delayed(const Duration(seconds: 1));

    // TODO: Call API update project + quyền tại đây

    setState(() => isLoading = false);

    if (!mounted) return;

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cài đặt chung"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// ===== TÊN NHÀ MÁY =====
            const Text(
              "Thông tin chung",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Dự án",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            /// ===== LOẠI TÀI KHOẢN =====
            const Text(
              "Loại tài khoản",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            ...AccountType.values.map((type) {
              return RadioListTile<AccountType>(
                title: Text(_mapAccountType(type)),
                value: type,
                groupValue: selectedType,
                onChanged: (value) {
                  _handleAccountTypeChange(value!);
                },
              );
            }).toList(),

            const SizedBox(height: 20),

            /// ===== PHÂN QUYỀN =====
            const Text(
              "Phân quyền",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            ...permissions.keys.map((key) {
              return CheckboxListTile(
                title: Text(_mapPermission(key)),
                value: permissions[key],
                onChanged: selectedType == AccountType.admin
                    ? null
                    : (value) {
                  setState(() {
                    permissions[key] = value!;
                  });
                },
              );
            }).toList(),

            const SizedBox(height: 30),

            /// ===== NÚT LƯU =====
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: isLoading ? null : _handleSave,
                child: isLoading
                    ? const CircularProgressIndicator(
                  color: Colors.white,
                )
                    : const Text("Lưu thay đổi"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}