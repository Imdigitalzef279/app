import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/application/cubit/app_cubit.dart';
import 'package:solar_energy/data/dto/meter/request/meter_request.dart';
import 'package:solar_energy/data/dto/meter/response/meter_response.dart';
import 'package:solar_energy/domain/arguments/electric_meter/electric_meter_argument.dart';
import 'package:solar_energy/presentation/common_widgets/app_toast.dart';
import 'package:solar_energy/presentation/screen/device/bloc/device_cubit.dart';
import 'package:solar_energy/presentation/screen/device/widget/item_device.dart';

class DevicesScreen extends StatefulWidget {
  const DevicesScreen({super.key, required this.argument});

  final ElectricMeterArgument argument;

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  late final DeviceCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<DeviceCubit>(context);
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      _cubit.getDevices(
          powerStationId: widget.argument.project.id,
          type: widget.argument.type);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () =>
                  _showCreateStationDialog(context, widget.argument.project.id),
              icon: const Icon(
                Icons.add,
                size: 22,
              ))
        ],
        title: Text(
          "Danh sách thiết bị",
          style: AppTextStyle.textBase.copyWith(
              color: AppColors.textPrimary, fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: AppColors.greyFB,
      body: SafeArea(
        child: BlocConsumer<DeviceCubit, DeviceState>(
          listener: (context, state) {
            state.resultDevices.when(
                loading: () => BlocProvider.of<AppCubit>(context).showLoading(),
                success: (data) =>
                    BlocProvider.of<AppCubit>(context).hideShowLoading(),
                error: (error) {
                  BlocProvider.of<AppCubit>(context).hideShowLoading();
                  AppToast.showToastError(title: error);
                });
          },
          builder: (BuildContext context, DeviceState state) {
            return state.resultDevices.data != null &&
                    state.resultDevices.data != []
                ? ListView.separated(
                    padding: EdgeInsets.all(12.sp),
                    itemBuilder: (context, index) =>
                        ItemDevice(device: state.resultDevices.data![index]),
                    separatorBuilder: (context, index) => Gap(12.sp),
                    itemCount: state.resultDevices.data?.length ?? 0)
                : Center(
                    child: Text(
                      'Không có dữ liệu',
                      style: AppTextStyle.textXs.copyWith(
                          fontSize: 12.sp, color: AppColors.textPrimary),
                    ),
                  );
          },
        ),
      ),
    );
  }

  void _showCreateStationDialog(BuildContext context, int projectId) {
    final _formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Thêm Thiết Bị Mới"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "PowerStation ID: $projectId",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 16),
                // Nhập tên trạm
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Tên thiết bị",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "Vui lòng nhập tên thiết bị"
                      : null,
                ),
                const SizedBox(height: 12),
                // Nhập mô tả
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: "Mô tả",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "Vui lòng nhập mô tả"
                      : null,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => backWidget(),
              child: const Text("Huỷ"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  final requestBody = MeterRequest(
                    name: nameController.text,
                    powerStationId: projectId,
                    description: descriptionController.text,
                    meterTypeId: _cubit.toMeterTypeIds(widget.argument.type)
                  );

                  final check = await _cubit.createPowerStation(requestBody);
                  backWidget();
                  if (check) {
                    _cubit.getDevices(
                        powerStationId: widget.argument.project.id,
                        type: widget.argument.type);
                  }
                }
              },
              child: const Text("Tạo"),
            ),
          ],
        );
      },
    );
  }

  void backWidget() {
    Navigator.pop(context);
  }
}
