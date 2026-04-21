import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../application/enums/chart_range.dart';
import '../../../../data/dto/device/response/device_response.dart';
import '../../../../data/dto/energy_report/energy_report_response.dart';
import '../../../../data/dto/notification_item/notification_item.dart';
import 'bloc/analytics_cubit.dart';
import 'dart:math' as math;
class AnalyticsDetailScreen extends StatefulWidget {
  final DeviceResponse device;

  const AnalyticsDetailScreen({super.key, required this.device});

  @override
  State<AnalyticsDetailScreen> createState() =>
      _AnalyticsDetailScreenState();
}

class _AnalyticsDetailScreenState extends State<AnalyticsDetailScreen> {
  ChartRange selectedRange = ChartRange.day;
  int selectedChart = 0;

  @override
  void initState() {
    super.initState();
    context.read<AnalyticsCubit>().loadEnergy(
      powerStationId: widget.device.powerStationId,
      deviceId: widget.device.id,
      type: "DAY",
    );
  }

  // ================= FILTER =================
  Widget buildFilterBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _filter("Ngày", ChartRange.day),
        _filter("Tháng", ChartRange.month),
        _filter("Năm", ChartRange.year),
      ],
    );
  }

  Widget _filter(String text, ChartRange range) {
    final active = selectedRange == range;

    return GestureDetector(
      onTap: () {
        setState(() => selectedRange = range);

        context.read<AnalyticsCubit>().loadEnergy(
          powerStationId: widget.device.powerStationId,
          deviceId: widget.device.id,
          type: range.name.toUpperCase(),
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 8),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: active ? Colors.green : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: active ? Colors.white : Colors.black87,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  // ================= TAB =================
  Widget buildTabs() {
    final tabs = ["Công suất (kW)", "Điện năng (kWh)"];

    return Row(
      children: List.generate(tabs.length, (i) {
        final active = selectedChart == i;

        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => selectedChart = i),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: active ? Colors.green : Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  tabs[i],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: active ? Colors.white : Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
  // ================= KPI =================
  Widget buildHeader(List<EnergyReportResponse> data) {
    if (data.isEmpty) return SizedBox();

    final percent = calculatePercentChange(data, context.read<AnalyticsCubit>().state.data);

    final values = data.map((e) {
      return selectedChart == 0 ? e.p : e.epi;
    }).toList();

    final total = values.fold(0.0, (a, b) => a + b);
    final avg = values.reduce((a, b) => a + b) / values.length;
    final max = values.reduce((a, b) => a > b ? a : b);
    final maxIndex = values.indexOf(max);
    final peakTime = data[maxIndex].time;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _kpi(
              selectedChart == 0 ? "Công suất" : "Điện năng",
              total,
              selectedChart == 0 ? "kW" : "kWh",
            ),
            _kpi("TB", avg, "kW"),
            _kpi("Peak", max, "kW"),
          ],
        ),

        SizedBox(height: 10),

        Row(
          children: [
            // % change
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: percent >= 0
                    ? Colors.red.withOpacity(0.1)
                    : Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(
                    percent >= 0
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                    color: percent >= 0 ? Colors.red : Colors.green,
                    size: 14,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "${percent.abs().toStringAsFixed(1)}%",
                    style: TextStyle(
                      color: percent >= 0 ? Colors.red : Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 12),

            // peak info
            Text(
              "Peak ${peakTime.hour}h (${max.toStringAsFixed(1)} kW)",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        )
      ],
    );
  }
  bool isPremium = false;
  Widget buildPremiumBlock(List<EnergyReportResponse> data) {
    if (!isPremium) {
      return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text("🔒 Tính năng Premium"),
            SizedBox(height: 6),
            Text("Mở khóa AI phân tích & dự đoán tiền điện"),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              child: Text("Nâng cấp"),
            )
          ],
        ),
      );
    }

    final bill = predictBill(data);
    final insight = generateAIInsight(data);

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("🤖 Phân tích AI"),
          SizedBox(height: 6),
          Text(insight),
          SizedBox(height: 10),
          Text("💸 Dự đoán: ${bill.toStringAsFixed(0)} đ"),
        ],
      ),
    );
  }
  Widget _kpi(String title, double value, String unit) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF69C21), Color(0xFFFBBF24)],
          ),
          borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.orange.withOpacity(0.2),
                blurRadius: 6,
                offset: Offset(0, 3),
              )
            ]
        ),

        child: Column(
          children: [
            Text(title, style: TextStyle(color: Colors.white70, fontSize: 12)),
            SizedBox(height: 6),
            Text(
              value.toStringAsFixed(1),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(unit, style: TextStyle(color: Colors.white54, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  // ================= CHART =================
  Widget buildChart(List<EnergyReportResponse> data) {
    final displayData = data;
    if (selectedRange == ChartRange.day && displayData.length <= 1) {
      return SizedBox(
        height: 260,
        child: Center(
          child: Text(
            "Chưa có đủ dữ liệu trong ngày",
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }
    final rawValues = displayData.map<double>((e) {
      return selectedChart == 0 ? e.p : e.epi;
    }).toList();

    final maxRaw =
    rawValues.isEmpty ? 1.0 : rawValues.reduce((a, b) => a > b ? a : b);

    final scaleFactor = maxRaw < 10 ? 1000 : 1;

    final values = rawValues.map((e) => e * scaleFactor).toList();

    final max =
    values.isEmpty ? 1.0 : values.reduce((a, b) => a > b ? a : b);

    final maxIndex = values.indexOf(max);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: math.max(displayData.length * 40, MediaQuery.of(context).size.width),
        height: 260,
        child: BarChart(
          BarChartData(
            barTouchData: BarTouchData(
              enabled: true,
              touchTooltipData: BarTouchTooltipData(
                getTooltipColor: (touchedSpot) => Colors.black87,
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  final index = group.x.toInt();
                  final item = displayData[index];
                  final value = (rod.toY / scaleFactor);

                  return BarTooltipItem(
                    "${item.time.hour}:00\n",
                    TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                    ),
                    children: [
                      TextSpan(
                        text: "${value.toStringAsFixed(2)} ${selectedChart == 0 ? "kW" : "kWh"}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            alignment: BarChartAlignment.spaceBetween,
            maxY: max == 0 ? 1 : max * 1.2,

            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: max / 3,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey.withOpacity(0.15),
                  strokeWidth: 0.8,
                );
              },
            ),

            borderData: FlBorderData(show: false),

            titlesData: FlTitlesData(
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),

              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, _) {
                    final index = value.toInt();
                    if (index >= displayData.length) return SizedBox();

                    final time = displayData[index].time;

                    if (selectedRange == ChartRange.day) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          "${time.hour}h",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[600],
                          ),
                        ),
                      );
                    } else if (selectedRange == ChartRange.month) {
                      return Text("${time.day}",
                          style: TextStyle(fontSize: 10));
                    } else {
                      return Text("${time.month}",
                          style: TextStyle(fontSize: 10));
                    }
                  },
                ),
              ),

              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 45,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      (value / scaleFactor).toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                      ),
                    );
                  },
                ),
              ),
            ),

            barGroups: values.asMap().entries.map((e) {
              final index = e.key;
              final value = e.value;

              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: value,
                    width: 10,
                    borderRadius: BorderRadius.circular(2),
                    color: index == maxIndex
                        ? Color(0xFF1E3A5F)
                        : Color(0xFF2C5C85),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
  List<NotificationItem> generateAlerts(
      List<double> values,
      List<EnergyReportResponse> data,
      ) {
    final avg = values.reduce((a, b) => a + b) / values.length;

    List<NotificationItem> alerts = [];

    for (int i = 0; i < values.length; i++) {
      if (values[i] > avg * 1.5) {
        alerts.add(
          NotificationItem(
            title: "Cảnh báo",
            message: "Công suất cao bất thường lúc ${data[i].time.hour}h",
            time: data[i].time,
            isAlert: true,
          ),
        );
      }
    }

    return alerts;
  }
  NotificationItem generateInsight(
      List<double> values,
      List<EnergyReportResponse> data,
      ) {
    final max = values.reduce((a, b) => a > b ? a : b);
    final maxIndex = values.indexOf(max);
    final hour = data[maxIndex].time.hour;

    String message;

    if (hour >= 18) {
      message = "Bạn dùng nhiều điện vào buổi tối";
    } else if (hour >= 12) {
      message = "Tiêu thụ cao vào buổi trưa";
    } else {
      message = "Tiêu thụ ổn định";
    }

    return NotificationItem(
      title: "Phân tích",
      message: message,
      time: DateTime.now(),
    );
  }
  Future<void> saveNotifications(List<NotificationItem> list) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonList = list.map((e) => {
      "title": e.title,
      "message": e.message,
      "time": e.time.toIso8601String(),
      "isAlert": e.isAlert,
    }).toList();

    prefs.setString("local_notifications", jsonEncode(jsonList));
  }
  Future<List<NotificationItem>> loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString("local_notifications");
    if (data == null) return [];

    final list = jsonDecode(data) as List;

    return list.map((e) => NotificationItem(
      title: e["title"],
      message: e["message"],
      time: DateTime.parse(e["time"]),
      isAlert: e["isAlert"],
    )).toList();
  }
  double calculatePercentChange(List<EnergyReportResponse> current, List<EnergyReportResponse> allData) {
    if (current.isEmpty) return 0;

    final currentTotal = current.fold(0.0, (a, b) =>
    a + (selectedChart == 0 ? b.p : b.epi));

    // lấy kỳ trước
    final prevData = allData.where((e) {
      final d = e.time;
      final now = DateTime.now();

      if (selectedRange == ChartRange.day) {
        final yesterday = now.subtract(Duration(days: 1));
        return d.day == yesterday.day &&
            d.month == yesterday.month &&
            d.year == yesterday.year;
      } else if (selectedRange == ChartRange.month) {
        return d.month == now.month - 1 && d.year == now.year;
      } else {
        return d.year == now.year - 1;
      }
    }).toList();

    if (prevData.isEmpty) return 0;

    final prevTotal = prevData.fold(0.0, (a, b) =>
    a + (selectedChart == 0 ? b.p : b.epi));

    if (prevTotal == 0) return 0;

    return ((currentTotal - prevTotal) / prevTotal) * 100;
  }
  double predictBill(List<EnergyReportResponse> data) {
    if (data.isEmpty) return 0;

    final total = data.fold(0.0, (a, b) => a + b.epi);
    final days = DateTime.now().day;

    final avgPerDay = total / days;

    return avgPerDay * 30 * 2500; // giá điện VN
  }
  String generateAIInsight(List<EnergyReportResponse> data) {
    if (data.isEmpty) return "Chưa có dữ liệu";

    final values = data.map((e) => e.epi).toList();
    final avg = values.reduce((a, b) => a + b) / values.length;
    final max = values.reduce((a, b) => a > b ? a : b);

    if (max > avg * 1.5) {
      return "⚠️ Có mức tiêu thụ bất thường, nên kiểm tra thiết bị";
    } else if (avg > 5) {
      return "💡 Mức tiêu thụ khá cao, có thể tối ưu để tiết kiệm";
    } else {
      return "✅ Tiêu thụ điện ổn định";
    }
  }
  // ================= FILTER DATA =================
  List<EnergyReportResponse> applyRange(
      List<EnergyReportResponse> data,
      ChartRange range,
      ) {
    final now = DateTime.now();

    final filtered = data.where((e) {
      final d = e.time;

      switch (range) {
        case ChartRange.day:
          return d.day == now.day &&
              d.month == now.month &&
              d.year == now.year;

        case ChartRange.month:
          return d.month == now.month && d.year == now.year;

        case ChartRange.year:
          return d.year == now.year;

        default:
          return true;
      }
    }).toList();

    filtered.sort((a, b) => a.time.compareTo(b.time));
    return filtered;
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AnalyticsCubit>().state;
    final data = applyRange(state.data, selectedRange);
    bool _saved = false;
    if (data.isNotEmpty && !_saved) {
      _saved = true;

      final values = data.map((e) {
        return selectedChart == 0 ? e.p : e.epi;
      }).toList();

      final alerts = generateAlerts(values, data);
      final insight = generateInsight(values, data);

      final allLocal = [
        ...alerts,
        insight,
      ];

      saveNotifications(allLocal);
    }
    return Scaffold(
      appBar: AppBar(title: Text(widget.device.name ?? "")),
      body: Container(
        color: Color(0xFFF5F7FB),
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.all(12),
              children: [
                buildFilterBar(),
                SizedBox(height: 12),

                buildTabs(),
                SizedBox(height: 12),

                buildHeader(data),
                SizedBox(height: 12),
                buildPremiumBlock(data),
                SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedChart == 0 ? "Power (kW)" : "Energy (kWh)",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 12),
                      buildChart(data),
                    ],
                  ),
                ),

                SizedBox(height: 20),
              ],
            ),

            if (state.isLoading)
              Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
          ],
        ),
      ),
    );
  }
}