import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../application/cubit/app_cubit.dart';
import '../../../../data/data_sources/api/api_client.dart';

import '../../../../data/dto/project/request/create_project_request.dart';

import '../AddPowerStationScreen/AddPowerStationScreen.dart';

import 'package:dio/dio.dart';
class CreateProjectScreen extends StatefulWidget {
  final int projectId;

  const CreateProjectScreen({
    super.key,
    required this.projectId,
  });

  @override
  State<CreateProjectScreen> createState() =>
      _CreateProjectScreenState();
}

class _CreateProjectScreenState
    extends State<CreateProjectScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppCubit>().hideShowLoading();
    });
  }

  final nameController = TextEditingController();
  final codeController = TextEditingController();
  final descriptionController = TextEditingController();

  bool loading = false;

  Future<void> _createProject() async {
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Vui lòng nhập tên dự án"),
        ),
      );
      return;
    }

    try {
      setState(() => loading = true);
      print("PROJECT ID = ${widget.projectId}");
      print("NAME = ${nameController.text}");
      print("CODE = ${codeController.text}");
      final project =
      await GetIt.I<ApiClient>().createProject(
        CreateProjectRequest(
          name: nameController.text.trim(),
          info: descriptionController.text.trim(),
        ),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Tạo dự án thành công"),
        ),
      );

      print("CREATE SUCCESS");

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => AddPowerStationScreen(
            projectId: project.id!,
          ),
        ),
      );
    } catch (e) {
      print("ERROR = $e");

      if (e is DioException) {
        print("STATUS CODE = ${e.response?.statusCode}");
        print("RESPONSE DATA = ${e.response?.data}");
        print("REQUEST DATA = ${e.requestOptions.data}");
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  InputDecoration _inputDecoration(
      String label,
      IconData icon,
      ) {
    return InputDecoration(
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
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    codeController.dispose();
    descriptionController.dispose();
    super.dispose();
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
          "Tạo dự án mới",
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
                        Icons.solar_power,
                        color: Color(0xFF1ABC9C),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Thông tin dự án",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    controller: nameController,
                    decoration: _inputDecoration(
                      "Tên dự án *",
                      Icons.business_outlined,
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    controller: codeController,
                    decoration: _inputDecoration(
                      "Mã dự án",
                      Icons.qr_code_outlined,
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    controller: descriptionController,
                    maxLines: 4,
                    decoration: _inputDecoration(
                      "Mô tả",
                      Icons.description_outlined,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Container(
              height: 58,
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(40),
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
                  loading ? null : _createProject,
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
                      "Tạo dự án",
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
}