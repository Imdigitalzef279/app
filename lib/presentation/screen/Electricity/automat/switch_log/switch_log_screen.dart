import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../application/switch_log/switch_log_cubit.dart';
import '../../../../../data/repositories/aptomat_log/switch_log_model.dart';

class SwitchLogScreen extends StatelessWidget {
  final String gatewaySn;

  const SwitchLogScreen({super.key, required this.gatewaySn});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lịch sử đóng cắt"),
      ),
      body: BlocBuilder<SwitchLogCubit, SwitchLogState>(
        builder: (context, state) {
          if (state is SwitchLogLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SwitchLogLoaded) {
            if (state.logs.isEmpty) {
              return const Center(child: Text("Không có dữ liệu"));
            }

            return ListView.builder(
              itemCount: state.logs.length,
              itemBuilder: (context, index) {
                final log = state.logs[index];
                return _buildLogItem(log);
              },
            );
          }

          return const Center(child: Text("Không có dữ liệu"));
        },
      ),
    );
  }
}

Widget _buildLogItem(SwitchLogModel log) {
  final isOn = log.action == "ĐÓNG";

  final statusText = _mapStatus(log.status ?? "");
  final statusColor = _mapStatusColor(log.status ?? "");

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border(
        left: BorderSide(
          color: isOn ? Colors.green : Colors.red,
          width: 4,
        ),
      ),
      boxShadow: [
        BoxShadow(
          blurRadius: 6,
          color: Colors.black.withOpacity(0.05),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// DÒNG 1: ACTION + STATUS
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              log.action ?? "",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: isOn ? Colors.green : Colors.red,
              ),
            ),
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                statusText,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        /// DÒNG 2: THỜI GIAN
        Text(
          DateFormat('dd/MM/yyyy HH:mm').format(log.time),
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black87,
          ),
        ),

        const SizedBox(height: 6),

        /// DÒNG 3: METHOD + USER
        Text(
          "${log.method ?? ''} • ${log.user ?? ''}",
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  );
}

String _mapStatus(String status) {
  switch (status.toUpperCase()) {
    case "SENT":
      return "Đã gửi";
    case "DONE":
      return "Hoàn thành";
    case "FAILED":
      return "Thất bại";
    default:
      return status;
  }
}

Color _mapStatusColor(String status) {
  switch (status.toUpperCase()) {
    case "SENT":
      return Colors.orange;
    case "DONE":
      return Colors.green;
    case "FAILED":
      return Colors.red;
    default:
      return Colors.grey;
  }
}