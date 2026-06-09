import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/data/dto/meter/request/meter_request.dart';

import '../../../data/data_sources/api/api_client.dart';
import '../../../data/dto/power_station/response/power_station_response.dart';
import 'general_device_screen.dart';

class AddProductScreen extends StatefulWidget {
  final PowerStationResponse powerStation;

  const AddProductScreen({
    super.key,
    required this.powerStation,
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
        powerStationId: widget.powerStation.id!,
        name: _nameController.text.trim(),
        code: _codeController.text.trim(),
        description: _descriptionController.text.trim(),
        gatewayNumber: _gatewayController.text.trim(),
        serialNumber: _serialController.text.trim(),
      );
      debugPrint('''
CREATE DEVICE:
powerStationId=${widget.powerStation.id}
name=${_nameController.text}
code=${_codeController.text}
description=${_descriptionController.text}
gateway=${_gatewayController.text}
serial=${_serialController.text}
''');
      debugPrint('===== CREATE DEVICE =====');
      print('===== CREATE DEVICE =====');
      print(request.toJson());
      print('=========================');
      debugPrint('=========================');
      await GetIt.instance<ApiClient>().createMeter(request);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Thêm thiết bị thành công'),
        ),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => GeneralDeviceScreen(
            project: widget.powerStation,
          ),
        ),
            (route) => false,
      );
    } on DioException catch (e) {
      debugPrint('===== ERROR =====');
      print('===== ERROR =====');
      print('STATUS: ${e.response?.statusCode}');
      print('DATA: ${e.response?.data}');
      print('===============');
      debugPrint('===============');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.response?.data?['error']?['message'] ??
                e.toString(),
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      debugPrint('ERROR: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
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
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint.tr(),
          prefixIcon: Icon(
            icon,
            color: Colors.grey.shade600,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide(
              color: AppColors.blueEA,
              width: 1.5,
            ),
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
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Thêm thiết bị".tr(),
          style: AppTextStyle.textBase.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              margin: EdgeInsets.only(bottom: 20.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppColors.blueEA.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.devices_other,
                      color: AppColors.blueEA,
                      size: 26.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Thiết bị mới",
                          style: AppTextStyle.textBase.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "Nhập thông tin thiết bị để thêm vào hệ thống",
                          style: AppTextStyle.textSm.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            _buildTextField(
              hint: "Tên thiết bị",
              controller: _nameController,
              icon: Icons.devices,
            ),

            _buildTextField(
              hint: "Mã thiết bị",
              controller: _codeController,
              icon: Icons.qr_code,
            ),

            _buildTextField(
              hint: "Mô tả",
              controller: _descriptionController,
              icon: Icons.description_outlined,
              maxLines: 2,
            ),

            _buildTextField(
              hint: "Gateway Number",
              controller: _gatewayController,
              icon: Icons.router,
            ),

            _buildTextField(
              hint: "Serial Number",
              controller: _serialController,
              icon: Icons.confirmation_number_outlined,
            ),

            SizedBox(height: 12.h),

            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveDevice,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppColors.blueEA,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.save_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "Lưu thiết bị".tr(),
                      style: AppTextStyle.textSm.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}