import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../application/switch_log/switch_log_cubit.dart';
import '../../../../../data/dto/breaker_command/breaker_command_dto.dart';
import '../../../../../data/repositories/breaker/breaker_repository.dart';
import '../../../../../di.dart';
import '../../../../breaker_history/cubit/breaker_history_cubit.dart';
import '../../../../breaker_history/cubit/breaker_history_state.dart';

class SwitchLogScreen extends StatelessWidget {
  final String gatewaySn;
  final String breakerSn;

  const SwitchLogScreen({
    super.key,
    required this.gatewaySn,
    required this.breakerSn,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BreakerHistoryCubit>(
      create: (_) =>
      BreakerHistoryCubit(
        getIt<BreakerRepository>(),
      )
        ..loadHistory(gatewaySn, breakerSn),

      child: Scaffold(
        appBar: AppBar(
          title: const Text("Lịch sử đóng cắt"),
        ),
        body: BlocBuilder<BreakerHistoryCubit, BreakerHistoryState>(
          builder: (context, state) {
            if (state is BreakerHistoryLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is BreakerHistoryLoaded) {
              if (state.logs.isEmpty) {
                return const Center(
                  child: Text("Không có dữ liệu"),
                );
              }

              return ListView.builder(
                itemCount: state.logs.length,
                itemBuilder: (context, index) {
                  final log = state.logs[index];
                  return _buildLogItem(log);
                },
              );
            }

            return const Center(
              child: Text("Không có dữ liệu"),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLogItem(BreakerCommandModel log) {
    final isOn = log.isClose;

    final statusText = _mapStatus(log.status);
    final statusColor = _mapStatusColor(log.status);

    return Container(
      margin:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            log.action,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color:
              isOn ? Colors.green : Colors.red,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            DateFormat('dd/MM/yyyy HH:mm')
                .format(log.sentAt),
          ),
          const SizedBox(height: 6),
          Text("${log.method} • ${log.createdBy}"),
        ],
      ),
    );
  }

  String _mapStatus(String status) {
    switch (status) {
      case "SENT":
      case "SUCCESS":
        return "Thành công";
      case "FAILED":
        return "Thất bại";
      default:
        return "Đang xử lý";
    }
  }

  Color _mapStatusColor(String status) {
    switch (status) {
      case "SENT":
      case "SUCCESS":
        return Colors.green;
      case "FAILED":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}