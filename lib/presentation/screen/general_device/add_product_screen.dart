import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/data/dto/meter/request/meter_request.dart';

import '../../../data/data_sources/api/api_client.dart';


class AddProductScreen extends StatefulWidget {
  final int powerStationId;

  const AddProductScreen({
    super.key,
    required this.powerStationId,
  });

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _gatewayController = TextEditingController();
  final _serialController = TextEditingController();

  bool _isLoading = false;

  Future<void> _saveDevice() async {
    if (_nameController.text.trim().isEmpty ||
        _codeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập tên và mã thiết bị'),
        ),
      );
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });

      final request = MeterRequest(
        meterTypeId: 2,
        powerStationId: widget.powerStationId,
        name: _nameController.text.trim(),
        code: _codeController.text.trim(),
        description: _descriptionController.text.trim(),
        gatewayNumber: _gatewayController.text.trim(),
        serialNumber: _serialController.text.trim(),
      );

      await GetIt.instance<ApiClient>().createMeter(request);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Thêm thiết bị thành công'),
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lỗi: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label.tr(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _descriptionController.dispose();
    _gatewayController.dispose();
    _serialController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyFB,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          "Thêm thiết bị".tr(),
          style: AppTextStyle.textBase.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            _buildTextField(
              label: "Tên thiết bị",
              controller: _nameController,
            ),

            _buildTextField(
              label: "Mã thiết bị",
              controller: _codeController,
            ),

            _buildTextField(
              label: "Mô tả",
              controller: _descriptionController,
            ),

            _buildTextField(
              label: "Gateway Number",
              controller: _gatewayController,
            ),

            _buildTextField(
              label: "Serial Number",
              controller: _serialController,
            ),

            SizedBox(height: 8.h),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveDevice,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blueEA,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : Text(
                  "Lưu thiết bị".tr(),
                  style: AppTextStyle.textSm.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
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