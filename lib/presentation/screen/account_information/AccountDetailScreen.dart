import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'Bloc/account_cubit.dart';

class AccountDetailScreen extends StatefulWidget {
  const AccountDetailScreen({super.key});

  @override
  State<AccountDetailScreen> createState() => _AccountDetailScreenState();
}

class _AccountDetailScreenState extends State<AccountDetailScreen> {
  String? avatarUrl;
  String phone = "";

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final res = await Dio().get("/profile");

    setState(() {
      avatarUrl = res.data["avatar"];
      phone = res.data["phone"] ?? "";
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text("Thông tin tài khoản"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),

          /// ===== AVATAR =====
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                child: GestureDetector(
                  onTap: _pickAndUploadAvatar,
                  child: GestureDetector(
                    onTap: _pickAndUploadAvatar,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundImage:
                      avatarUrl != null ? NetworkImage(avatarUrl!) : null,
                    ),
                  ),
                ),
              ),

              /// icon camera
              Positioned(
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// ===== NAME =====
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Trường",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 6),
              Icon(Icons.edit, size: 16),
            ],
          ),

          const SizedBox(height: 20),

          /// ===== LIST =====
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _item(
                    Icons.email,
                    "Mail",
                    "example@gmail.com",
                  ),
                  _divider(),

                  _item(
                    Icons.phone,
                    "Điện thoại",
                    phone,
                    onTap: _editPhone,
                  ),
                  _divider(),

                  _item(Icons.history, "Lịch sử đăng nhập", ""),
                  _divider(),

                  _item(Icons.lock, "Đổi mật khẩu", ""),
                ],
              ),
            ),
          ),

          /// ===== LOGOUT BUTTON =====
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  _confirmLogout(context);
                },
                child: const Text(
                  "Đăng xuất",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _editPhone() async {
    final controller = TextEditingController(text: phone);

    final result = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Sửa số điện thoại"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.phone,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Huỷ"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: Text("Lưu"),
          ),
        ],
      ),
    );

    if (result != null) {
      setState(() => phone = result);

      await Dio().post("/update-profile", data: {
        "phone": result,
      });

      context.read<AccountCubit>().getProfile();
    }
  }
  Future<void> _pickAndUploadAvatar() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);

    if (file == null) return;

    final dio = Dio();

    final formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path),
    });

    final res = await dio.post("/upload-avatar", data: formData);

    final newUrl = res.data["data"];

    setState(() {
      avatarUrl = newUrl;
    });

    context.read<AccountCubit>().getProfile();
  }

  /// ===== ITEM =====

  Widget _item(
      IconData icon,
      String title,
      String value, {
        VoidCallback? onTap,
      }) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(title),
      trailing: value.isNotEmpty
          ? Text(value, style: const TextStyle(color: Colors.grey))
          : const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  static Widget _divider() {
    return const Padding(
      padding: EdgeInsets.only(left: 56),
      child: Divider(height: 1),
    );
  }

  /// ===== LOGOUT =====
  static void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Đăng xuất"),
          content: const Text("Bạn có chắc muốn đăng xuất không?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Huỷ"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                      (route) => false,
                );
              },
              child: const Text("Đăng xuất"),
            ),
          ],
        );
      },
    );
  }
}