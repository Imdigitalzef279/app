import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/dto/power_station/response/power_station_response.dart';
import 'AddPowerStationScreen/AddPowerStationScreen.dart';
import 'background/bloc/background_cubit.dart';
import 'create_project/create_project_screen.dart';

enum AccountType {
  admin,
  technician,
  user,
  webPaid,
  appFree,
}
enum PackageType {
  basic,
  pro,
  enterprise,
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
  PackageType selectedPackage = PackageType.basic;
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
        SnackBar(
            content: Text("Tên dự án không được để trống".tr())),
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
  Future<void> _previewBackground(String path) async {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          insetPadding: EdgeInsets.all(12),
          child: Stack(
            children: [

              /// ảnh preview
              Positioned.fill(
                child: path.startsWith("assets")
                    ? Image.asset(path, fit: BoxFit.cover)
                    : Image.file(File(path), fit: BoxFit.cover),
              ),

              /// overlay
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),

              /// nút
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Huỷ".tr()),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<BackgroundCubit>().setBg(path);
                          Navigator.pop(context);
                        },
                        child: Text("Áp dụng".tr()),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF3F6FB),
        title:  Text("Cài đặt chung".tr()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            _buildProjectInfoCard(),

            const SizedBox(height: 12),

            _buildRoleSection(),

            const SizedBox(height: 12),

            _buildPermissionSection(),
            const SizedBox(height: 12),
            _buildPackageSection(),
            const SizedBox(height: 16),
            _buildBackgroundSection(),
            const SizedBox(height: 12),
            _buildSaveButton(),
            // _buildLogoutButton(context),
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
        borderRadius: BorderRadius.circular(16),
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
               Text(
                "Thông tin dự án".tr(),
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
                  child:  Row(
                    children: [
                      Icon(Icons.edit, size: 16),
                      SizedBox(width: 6),
                      Text("Chỉnh sửa".tr()),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Column(
            children: [
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

              const Divider(height: 24),

              InkWell(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CreateProjectScreen(
                        projectId: widget.project.projectId,
                      ),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        color: Color(0xFF1ABC9C),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "Tạo dự án mới",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
              const Divider(height: 20),

              InkWell(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddPowerStationScreen(
                        projectId: widget.project.projectId,
                      ),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.factory_outlined,
                        color: Color(0xFF1ABC9C),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "Tạo trạm mới",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // ================= ROLE SECTION =================

  Widget _buildRoleSection() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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

           Text(
            "Vai trò tài khoản".tr(),
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 18),

          LayoutBuilder(
            builder: (context, constraints) {

              final isTablet = constraints.maxWidth >= 600;

              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),

                /// tablet 2 cột rộng đẹp hơn
                crossAxisCount: isTablet ? 2 : 2,

                /// spacing
                mainAxisSpacing: isTablet ? 16 : 10,
                crossAxisSpacing: isTablet ? 16 : 10,

                /// tablet card thấp hơn để không dư trắng
                childAspectRatio: isTablet ? 2.2 : 1.5,

                children: [
                  _roleCard(
                    "Admin",
                    "Toàn quyền hệ thống".tr(),
                    AccountType.admin,
                  ),
                  _roleCard(
                    "Kỹ thuật",
                    "Cài đặt + bảo trì".tr(),
                    AccountType.technician,
                  ),
                  _roleCard(
                    "Người dùng",
                    "Chỉ xem dữ liệu".tr(),
                    AccountType.user,
                  ),
                  _roleCard(
                    "Web Pro",
                    "Trả phí - báo cáo nâng cao".tr(),
                    AccountType.webPaid,
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }

  Widget _roleCard(
      String title,
      String subtitle,
      AccountType type,
      ) {
    final bool isSelected = selectedType == type;

    Color roleColor;
    Color selectedBg;

    switch (type) {
      case AccountType.admin:
        roleColor = const Color(0xFF0E9F6E); // xanh đậm
        selectedBg = const Color(0xFFE7F6EF);
        break;

      case AccountType.webPaid:
        roleColor = const Color(0xFFF59E0B); // cam
        selectedBg = const Color(0xFFFFF4E5);
        break;

      case AccountType.technician:
        roleColor = const Color(0xFF6B7280); // xám
        selectedBg = const Color(0xFFF3F4F6);
        break;

      case AccountType.user:
      default:
        roleColor = const Color(0xFF1ABC9C); // xanh mint
        selectedBg = const Color(0xFFEAF8F5);
        break;
    }

    IconData? icon;
    if (type == AccountType.user) {
      icon = Icons.remove_red_eye_outlined;
    }

    return GestureDetector(
      onTap: () => _handleAccountTypeChange(type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(
          MediaQuery.of(context).size.width >= 600 ? 20 : 16,
        ),
        decoration: BoxDecoration(
          color: isSelected ? selectedBg : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? roleColor : Colors.grey.shade200,
            width: 1.2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Badge
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? roleColor.withValues(alpha:0.15)
                    : const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? roleColor : Colors.black87,
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.width >= 600 ? 10 : 14,
            ),

            /// Subtitle + optional icon
            Row(
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: 16,
                    color: isSelected ? roleColor : Colors.grey,
                  ),
                  const SizedBox(width: 6),
                ],
                Expanded(
                  child: Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: Color(0xFF9AA0A6),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ================= PERMISSION =================

  Widget _buildPermissionSection() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

         Text(
            "Phân quyền".tr(),
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
  // ================= PACKAGE SECTION =================

  Widget _buildPackageSection() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

           Text(
            "Gói dịch vụ".tr(),
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(
                child: _packageCard(
                  "Basic".tr(),
                  "Miễn phí".tr(),
                  PackageType.basic,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _packageCard(
                  "Pro",
                  "299k/tháng".tr(),
                  PackageType.pro,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _packageCard(
                  "Enterprise",
                  "Theo hợp đồng".tr(),
                  PackageType.enterprise,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildBackgroundSection() {
    final presets = [
      "assets/images/backgrounds/8machine-_-gCkv8mnmxm8-unsplash.jpg",
      "assets/images/backgrounds/brendan-sapp-voobNbqCQHY-unsplash.jpg",
      "assets/images/backgrounds/diego-ph-wyeapf7Gy-U-unsplash.jpg",
      "assets/images/backgrounds/itsiken-hs8bzEFVffc-unsplash.jpg",
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            "Hình nền".tr(),
            style: TextStyle(fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 16),

          /// GRID ẢNH
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: presets.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.6,
            ),
            itemBuilder: (_, index) {
              final img = presets[index];

              return GestureDetector(
                onTap: () => _previewBackground(img),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(img, fit: BoxFit.cover),
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          /// chọn ảnh máy
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    final picker = ImagePicker();
                    final file = await picker.pickImage(
                      source: ImageSource.gallery,
                    );

                    if (file != null) {
                      _previewBackground(file.path);
                    }
                  },
                  child: Text("Chọn ảnh".tr()),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<BackgroundCubit>().clear();
                  },
                  child: Text("Mặc định".tr()),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  Widget _packageCard(
      String title,
      String subtitle,
      PackageType type,
      ) {
    final bool isSelected = selectedPackage == type;

    Color roleColor;
    Color selectedBg;

    switch (type) {
      case PackageType.basic:
        roleColor = const Color(0xFF1ABC9C);
        selectedBg = const Color(0xFFEAF8F5);
        break;

      case PackageType.pro:
        roleColor = const Color(0xFFF59E0B);
        selectedBg = const Color(0xFFFFF4E5);
        break;

      case PackageType.enterprise:
        roleColor = const Color(0xFF111827);
        selectedBg = const Color(0xFFF3F4F6);
        break;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPackage = type;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 90,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? selectedBg : const Color(0xFFF7F7FA),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? roleColor : Colors.grey.shade200,
            width: 1.2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: roleColor,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF9AA0A6),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // ================= SAVE BUTTON =================

  Widget _buildSaveButton() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6ED7C3), // xanh nhạt
            Color(0xFF1ABC9C), // xanh chính
            Color(0xFF0E9F6E), // xanh đậm
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1ABC9C).withOpacity(0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(40),
          onTap: isLoading ? null : _handleSave,
          child: Center(
            child: isLoading
                ? const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2.5,
              ),
            )
                :  Text(
              "Lưu thay đổi".tr(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
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
           Text("Chỉnh sửa tên dự án".tr()),
          content: TextField(
            controller: nameController,
            decoration:
             InputDecoration(
              hintText:
              "Nhập tên dự án".tr(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context),
              child: Text("Huỷ".tr()),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {});
                Navigator.pop(context);
              },
              child:  Text("Lưu".tr()),
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

