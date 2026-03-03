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

  const ProjectSettingScreen({
    super.key,
    required this.project,
  });

  @override
  State<ProjectSettingScreen> createState() =>
      _ProjectSettingScreenState();
}

class _ProjectSettingScreenState
    extends State<ProjectSettingScreen> {

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

  // ================= SAVE =================

  Future<void> _handleSave() async {
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Tên dự án không được để trống")),
      );
      return;
    }

    setState(() => isLoading = true);

    await Future.delayed(const Duration(seconds: 1));

    setState(() => isLoading = false);

    if (!mounted) return;

    Navigator.pop(context, true);
  }

  // ================= ROLE CHANGE =================

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

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF3F6FB),
        title: const Text("Cài đặt chung"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            _buildProjectInfoCard(),

            const SizedBox(height: 24),

            _buildRoleSection(),

            const SizedBox(height: 24),

            _buildPermissionSection(),

            const SizedBox(height: 30),

            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  // ================= PROJECT CARD =================

  Widget _buildProjectInfoCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Thông tin dự án",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: _showEditNameDialog,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius:
                    BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.edit, size: 16),
                      SizedBox(width: 6),
                      Text("Chỉnh sửa"),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: Text(
                  nameController.text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ],
      ),
    );
  }

  // ================= ROLE SECTION =================

  Widget _buildRoleSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          const Text(
            "Vai trò tài khoản",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 18),

          GridView.count(
            shrinkWrap: true,
            physics:
            const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.35,
            children: [

              _roleCard(
                "Admin",
                "Toàn quyền hệ thống",
                AccountType.admin,
              ),
              _roleCard(
                "Kỹ thuật",
                "Cài đặt + bảo trì",
                AccountType.technician,
              ),
              _roleCard(
                "Người dùng",
                "Chỉ xem dữ liệu",
                AccountType.user,
              ),
              _roleCard(
                "Web Pro",
                "Trả phí - báo cáo nâng cao",
                AccountType.webPaid,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _roleCard(
      String title,
      String subtitle,
      AccountType type,
      ) {
    final bool isSelected =
        selectedType == type;

    return GestureDetector(
      onTap: () =>
          _handleAccountTypeChange(type),
      child: AnimatedContainer(
        duration:
        const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFE6F4F1)
              : Colors.white,
          borderRadius:
          BorderRadius.circular(22),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF1ABC9C)
                : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color:
              Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            Container(
              padding:
              const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF1ABC9C)
                    .withOpacity(0.15)
                    : const Color(0xFFF0F2F5),
                borderRadius:
                BorderRadius.circular(20),
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight:
                  FontWeight.w600,
                  color: isSelected
                      ? const Color(0xFF1ABC9C)
                      : Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF8E8E93),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= PERMISSION =================

  Widget _buildPermissionSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          const Text(
            "Phân quyền",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 12),

          ...permissions.keys.map((key) {
            return SwitchListTile(
              activeColor:
              const Color(0xFF1ABC9C),
              contentPadding:
              EdgeInsets.zero,
              title: Text(
                _mapPermission(key),
              ),
              value: permissions[key] ?? false,
              onChanged:
              selectedType ==
                  AccountType.admin
                  ? null
                  : (value) {
                setState(() {
                  permissions[key] =
                      value;
                });
              },
            );
          }).toList(),
        ],
      ),
    );
  }

  // ================= SAVE BUTTON =================

  Widget _buildSaveButton() {
    return SizedBox(
      height: 52,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF1ABC9C),
              Color(0xFF16A085),
            ],
          ),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
            Colors.transparent,
            shadowColor:
            Colors.transparent,
            shape:
            RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(
                  30),
            ),
          ),
          onPressed:
          isLoading ? null : _handleSave,
          child: isLoading
              ? const CircularProgressIndicator(
              color: Colors.white)
              : const Text(
            "Lưu thay đổi",
            style: TextStyle(
                fontWeight:
                FontWeight.w600),
          ),
        ),
      ),
    );
  }

  // ================= EDIT DIALOG =================

  void _showEditNameDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title:
          const Text("Chỉnh sửa tên dự án"),
          content: TextField(
            controller: nameController,
            decoration:
            const InputDecoration(
              hintText:
              "Nhập tên dự án",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context),
              child: const Text("Huỷ"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {});
                Navigator.pop(context);
              },
              child: const Text("Lưu"),
            ),
          ],
        );
      },
    );
  }

  String _mapPermission(String key) {
    switch (key) {
      case "view":
        return "Xem dữ liệu realtime";
      case "config":
        return "Cài đặt thông số";
      case "control":
        return "Đóng/Cắt thiết bị";
      case "report":
        return "Xuất báo cáo";
      case "addDevice":
        return "Thêm thiết bị";
      default:
        return key;
    }
  }
}