import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
            backgroundColor: Color(0xFFF5F7FA)
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
              final groupedLogs = _groupLogsByDate(state.logs);
              return Column(
                children: [

                  const SizedBox(height: 10),

                  _buildFilterTabs(),

                  const SizedBox(height: 8),

                  _buildFilterOptions(),

                  const SizedBox(height: 6),

                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: groupedLogs.entries.map((entry) {
                        final dateLabel = _getDateLabel(entry.key);
                        final logs = entry.value;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            const SizedBox(height: 14),

                            Text(
                              dateLabel,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),

                            const SizedBox(height: 6),

                            ...logs.map((log) => _buildLogItem(log)).toList(),
                          ],
                        );
                      }).toList(),
                    ),
                  )
                ],
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
  Widget _buildFilterOptions() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [

          _optionChip(Icons.access_time, "24 giờ"),

          const SizedBox(width: 8),

          _optionChip(Icons.memory, breakerSn),

          const SizedBox(width: 8),

          _optionChip(Icons.circle, "Tất cả mức độ"),

          const SizedBox(width: 8),

          const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
  Widget _buildFilterTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [

          _filterTab("Tất cả", true),

          const SizedBox(width: 12),

          _filterTab("Thao tác", false),

          const SizedBox(width: 12),

          _filterTab("Cảnh báo", false),

          const SizedBox(width: 12),

          _filterTab("Hệ thống", false),

          const SizedBox(width: 16),

          Row(
            children: const [
              Icon(Icons.tune, size: 18),
              SizedBox(width: 4),
              Text(
                "Bộ lọc",
                style: TextStyle(fontWeight: FontWeight.w500),
              )
            ],
          )
        ],
      ),
    );
  }
  Widget _filterTab(String text, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: active ? const Color(0xFF4FA89E) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: active ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
  Widget _optionChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [

          _chip("Tất cả", true),
          const SizedBox(width: 8),
          _chip("Thao tác", false),
          const SizedBox(width: 8),
          _chip("Cảnh báo", false),
          const SizedBox(width: 8),
          _chip("Hệ thống", false),

          const Spacer(),

          const Icon(Icons.tune, size: 20)
        ],
      ),
    );
  }
  Widget _chip(String text, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF4DB6AC) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selected ? const Color(0xFF4DB6AC) : Colors.grey.shade300,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          color: selected ? Colors.white : Colors.grey[700],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
  Widget _buildLogItem(BreakerCommandModel log) {

    final isClose = log.isClose;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// badge row
          Row(
            children: [

              _badge(Icons.flash_on, "Admin", Colors.green),

              const SizedBox(width: 6),

              _badge(Icons.settings, "System", Colors.teal),

              const Spacer(),

              Text(
                DateFormat("HH:mm").format(log.sentAt),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              )
            ],
          ),

          const SizedBox(height: 10),

          /// title
          Text(
            isClose
                ? "MCB đã đóng thiết bị thành công"
                : "MCB đã mở thiết bị",
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            "Điện tải: 0 kW → 2.5 kW",
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 10),

          Row(
            children: [

              Icon(
                Icons.bolt,
                size: 16,
                color: isClose ? Colors.green : Colors.red,
              ),

              const SizedBox(width: 6),

              Text(
                isClose ? "Đang cắt" : "Mở",
                style: TextStyle(
                  color: isClose ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const Spacer(),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  "Thành công",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  Widget _badge(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
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
Map<String, List<BreakerCommandModel>> _groupLogsByDate(List<BreakerCommandModel> logs) {
  final Map<String, List<BreakerCommandModel>> grouped = {};

  for (var log in logs) {
    final date = DateFormat("yyyy-MM-dd").format(log.sentAt);

    if (!grouped.containsKey(date)) {
      grouped[date] = [];
    }

    grouped[date]!.add(log);
  }

  return grouped;
}

String _getDateLabel(String date) {
  final today = DateFormat("yyyy-MM-dd").format(DateTime.now());
  final yesterday =
  DateFormat("yyyy-MM-dd").format(DateTime.now().subtract(const Duration(days: 1)));

  if (date == today) return "Hôm nay";
  if (date == yesterday) return "Hôm qua";

  return DateFormat("dd/MM/yyyy").format(DateTime.parse(date));
}