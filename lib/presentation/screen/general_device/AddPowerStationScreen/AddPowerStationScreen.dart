import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../data/data_sources/api/api_client.dart';
import '../../../../data/dto/power_station/request/power_station_request.dart';
import '../add_product_screen.dart';

class AddPowerStationScreen extends StatefulWidget {
  final int projectId;

  const AddPowerStationScreen({
    super.key,
    required this.projectId,
  });

  @override
  State<AddPowerStationScreen> createState() =>
      _AddPowerStationScreenState();
}

class _AddPowerStationScreenState
    extends State<AddPowerStationScreen> {

  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _descriptionController = TextEditingController();


  bool loading = false;

  Future<void> createStation() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Nhập tên trạm"),
        ),
      );
      return;
    }

    try {
      setState(() => loading = true);

      final api = GetIt.I<ApiClient>();

      final request = PowerStationRequest(
        projectId: widget.projectId,
        name: _nameController.text.trim(),
        code: _codeController.text.trim(),
        description: _descriptionController.text.trim(),
        longitude: "",
        latitude: "",
        planViewPath: "",
      );

      final result =
      await api.createPowerStation(request);

      debugPrint("Created station: ${result.id}");

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Tạo trạm thành công"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => AddProductScreen(
            powerStation: result,
          ),
        ),
      );

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Lỗi: $e"),
          backgroundColor: Colors.red,
        ),
      );

    } finally {

      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  Widget buildField(
      String title,
      TextEditingController controller,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: title,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF3F6FB),
        centerTitle: true,
        title: const Text(
          "Tạo trạm mới",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  const Row(
                    children: [
                      Icon(
                        Icons.factory_outlined,
                        color: Color(0xFF1ABC9C),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Thông tin trạm",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  _buildInput(
                    controller: _nameController,
                    label: "Tên trạm *",
                    icon: Icons.factory,
                  ),

                  const SizedBox(height: 16),

                  _buildInput(
                    controller: _codeController,
                    label: "Mã trạm",
                    icon: Icons.qr_code_outlined,
                  ),

                  const SizedBox(height: 16),

                  _buildInput(
                    controller: _descriptionController,
                    label: "Mô tả",
                    icon: Icons.description_outlined,
                    maxLines: 4,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Container(
              height: 58,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF6ED7C3),
                    Color(0xFF1ABC9C),
                    Color(0xFF0E9F6E),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1ABC9C)
                        .withOpacity(0.35),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                  BorderRadius.circular(40),
                  onTap:
                  loading ? null : createStation,
                  child: Center(
                    child: loading
                        ? const SizedBox(
                      width: 24,
                      height: 24,
                      child:
                      CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                        : const Text(
                      "Tạo trạm",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight:
                        FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildInput({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFF1ABC9C),
            width: 1.5,
          ),
        ),
      ),
    );
  }
}