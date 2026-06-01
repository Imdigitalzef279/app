import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../application/enums/chart_range.dart';
import '../../../../data/dto/device/response/device_response.dart';
import '../../../../data/dto/energy_report/energy_report_response.dart';
import '../../../../data/dto/notification_item/notification_item.dart';
import '../../../../data/dto/atomat/atomat_chart/breaker_chart_response.dart';
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
  int selectedTab = 0; // 0: Energy, 1: MCB
  bool isLineChart = false;
  @override
  void initState() {
    super.initState();
    context.read<AnalyticsCubit>().loadEnergy(
      powerStationId: widget.device.powerStationId,
      deviceId: widget.device.id,
      type: "DAY",
    );
    context.read<AnalyticsCubit>().loadBreakerChart(
        breakerSn: widget.device.code
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
  Widget buildMainTabs() {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _mainTab("Điện Năng", 0),
          _mainTab("Giám Sát", 1),
        ],
      ),
    );
  }
  Widget _mainTab(String title, int index) {
    final active = selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: active ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(14),

            boxShadow: active
                ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: Offset(0, 2),
              )
            ]
                : [],
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: active ? Colors.black : Colors.grey[600],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget buildChartTypeToggle() {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          _chartTypeButton(
            title: "Bar",
            active: !isLineChart,
            onTap: () => setState(() => isLineChart = false),
          ),
          _chartTypeButton(
            title: "Line",
            active: isLineChart,
            onTap: () => setState(() => isLineChart = true),
          ),
        ],
      ),
    );
  }
  Widget _chartTypeButton({
    required String title,
    required bool active,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: active
                ? Color(0xFF22C55E)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: active
                    ? Colors.white
                    : Colors.grey.shade600,
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget buildMCBCharts(List<BreakerChartResponse> data) {
    final current = data.map<double>((e) => (e.ia ?? 0).toDouble()).toList();
    final voltage = data.map<double>((e) => (e.ua ?? 0).toDouble()).toList();
    final temperature = data
        .map<double>((e) => (e.temp1 ?? 0).toDouble())
        .toList();
    final power = data.map<double>((e) => (e.p ?? 0).toDouble()).toList();

    return Column(
      children: [
        _chartBlock("Current (A)", current),
        _chartBlock("Voltage (V)", voltage),
        _chartBlock("Temperature (°C)", temperature),
        _chartBlock("Power (kW)", power),
      ],
    );
  }
  Widget _chartBlock(String title, List<double> values) {
    final sampledValues = values.length > 20
        ? values.asMap().entries
        .where((e) => e.key % 2 == 0)
        .map((e) => e.value)
        .toList()
        : values;
    return Container(

      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          SizedBox(
            height: 220,

            child: isLineChart

                ? LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: values.isNotEmpty
                      ? ((values.reduce((a, b) => a > b ? a : b) / 4) == 0
                      ? 1
                      : (values.reduce((a, b) => a > b ? a : b) / 4))
                      : 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.black.withOpacity(0.04),
                      strokeWidth: 0.7,
                    );
                  },
                ),

                titlesData: FlTitlesData(
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),

                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: math.max(1, (values.length / 5).ceil()).toDouble(),
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() % 2 != 0) return SizedBox();

                        return Text(
                          value.toInt().toString(),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      },
                    ),
                  ),

                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                ),

                borderData: FlBorderData(show: false),

                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (_) => Colors.black87,
                    getTooltipItems: (spots) {
                      return spots.map((spot) {
                        return LineTooltipItem(
                          spot.y.toStringAsFixed(2),
                          TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),

                lineBarsData: [
                  LineChartBarData(
                    spots: values.asMap().entries.map((e) {
                      return FlSpot(e.key.toDouble(), e.value);
                    }).toList(),

                    isCurved: true,
                    curveSmoothness: 0.22,
                    isStrokeCapRound: true,

                    shadow: Shadow(
                      color: Colors.transparent,
                    ),

                    color: Color(0xFF22C55E),

                    barWidth: 2.2,

                    dotData: FlDotData(
                      show: false,
                    ),

                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF22C55E).withOpacity(0.08),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
                : BarChart(

                BarChartData(
                  alignment: BarChartAlignment.spaceEvenly,
                  groupsSpace: 2,

                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: values.isEmpty
                        ? 1
                        : math.max(1, (values.reduce((a, b) => a > b ? a : b) / 4)),
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.black.withOpacity(0.035),
                      strokeWidth: 0.6,
                    ),
                  ),

                  titlesData: FlTitlesData(
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),

                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: math.max(1, (sampledValues.length / 5).ceil()).toDouble(),
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() % 2 != 0) return SizedBox();
                          return Text(
                            value.toInt().toString(),
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          );
                        },
                      ),
                    ),

                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  borderData: FlBorderData(show: false),

                  barGroups: values.asMap().entries.map((e) {
                    return BarChartGroupData(
                      x: e.key,
                      barRods: [
                        BarChartRodData(
                          toY: e.value,
                          width: 14,

                          borderRadius: BorderRadius.circular(12),

                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Color(0xFF86EFAC).withOpacity(0.9),
                              Color(0xFF34D399).withOpacity(0.75),
                            ],
                          ),
                        )
                      ],
                    );
                  }).toList(),
                )
            ),
          ),
        ],
      ),
    );
  }
  // ================= KPI =================
  Widget buildHeader(List<EnergyReportResponse> data) {
    final values = data.isEmpty
        ? [0.0]
        : data.map((e) => selectedChart == 0 ? e.p : e.epi).toList();

    final total = values.fold(0.0, (a, b) => a + b);
    final avg = values.reduce((a, b) => a + b) / values.length;
    final max = values.reduce((a, b) => a > b ? a : b);

    final peakTime = data.isEmpty
        ? DateTime.now()
        : data[values.indexOf(max)].time;

    final percent = data.isEmpty
        ? 0
        : calculatePercentChange(data, context.read<AnalyticsCubit>().state.data);

    return Column(
      mainAxisSize: MainAxisSize.min,
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
  Widget buildCompareCards(
      List<EnergyReportResponse> data,
      ) {
    final now = DateTime.now();

    double today = 0;
    double yesterday = 0;
    double thisWeek = 0;
    double lastWeek = 0;
    double thisMonth = 0;
    double lastMonth = 0;
    double thisYear = 0;
    double lastYear = 0;

    final allData = context.read<AnalyticsCubit>().state.data;

    for (final e in allData) {
      final d = e.time;
      final value = selectedChart == 0 ? e.p : e.epi;

      // TODAY
      if (d.year == now.year &&
          d.month == now.month &&
          d.day == now.day) {
        today += value;
      }

      // YESTERDAY
      final ytd = now.subtract(Duration(days: 1));

      if (d.year == ytd.year &&
          d.month == ytd.month &&
          d.day == ytd.day) {
        yesterday += value;
      }

      // THIS WEEK
      final startThisWeek =
      DateTime(now.year, now.month, now.day)
          .subtract(Duration(days: now.weekday - 1));

      if (d.isAfter(startThisWeek.subtract(Duration(seconds: 1)))) {
        thisWeek += value;
      }

      // LAST WEEK
      final startLastWeek =
      startThisWeek.subtract(Duration(days: 7));

      if (d.isAfter(startLastWeek.subtract(Duration(seconds: 1))) &&
          d.isBefore(startThisWeek)) {
        lastWeek += value;
      }

      // THIS MONTH
      if (d.year == now.year &&
          d.month == now.month) {
        thisMonth += value;
      }

      // LAST MONTH
      final prevMonth = now.month == 1 ? 12 : now.month - 1;
      final prevMonthYear =
      now.month == 1 ? now.year - 1 : now.year;

      if (d.year == prevMonthYear &&
          d.month == prevMonth) {
        lastMonth += value;
      }

      // THIS YEAR
      if (d.year == now.year) {
        thisYear += value;
      }

      // LAST YEAR
      if (d.year == now.year - 1) {
        lastYear += value;
      }
    }
    String currentLabel1 = "";
    String previousLabel1 = "";
    String currentLabel2 = "";
    String previousLabel2 = "";

    switch (selectedRange) {
      case ChartRange.day:
        currentLabel1 = "Hôm nay";
        previousLabel1 = "Hôm qua";
        currentLabel2 = "Tuần này";
        previousLabel2 = "Tuần trước";
        break;

      case ChartRange.month:
        currentLabel1 = "Tháng này";
        previousLabel1 = "Tháng trước";
        currentLabel2 = "Quý này";
        previousLabel2 = "Quý trước";
        break;

      case ChartRange.quarter:
        currentLabel1 = "Quý này";
        previousLabel1 = "Quý trước";
        currentLabel2 = "Nửa năm";
        previousLabel2 = "Nửa năm trước";
        break;

      case ChartRange.year:
        currentLabel1 = "Năm nay";
        previousLabel1 = "Năm trước";
        currentLabel2 = "5 năm";
        previousLabel2 = "5 năm trước";
        break;
      case ChartRange.week:
        // TODO: Handle this case.
        throw UnimplementedError();
    }

    return Row(
      children: [
        Expanded(
          child: _compareCard(
            title: currentLabel1,
            value: selectedRange == ChartRange.day
                ? today
                : selectedRange == ChartRange.month
                ? thisMonth
                : thisYear,
            percent: yesterday == 0
                ? 0
                : ((today - yesterday) / yesterday) * 100,
            color: Color(0xFF22C55E),
          ),
        ),

        SizedBox(width: 8),

        Expanded(
          child: _compareCard(
            title: previousLabel1,
            value: selectedRange == ChartRange.day
                ? yesterday
                : selectedRange == ChartRange.month
                ? lastMonth
                : lastYear,
            percent: null,
            color: Color(0xFF94A3B8),
          ),
        ),

        SizedBox(width: 8),

        Expanded(
          child: _compareCard(
            title: currentLabel2,
            value: thisWeek,
            percent: lastWeek == 0
                ? 0
                : ((thisWeek - lastWeek) / lastWeek) * 100,
            color: Color(0xFF3B82F6),
          ),
        ),

        SizedBox(width: 8),

        Expanded(
          child: _compareCard(
            title: previousLabel2,
            value: lastWeek,
            percent: null,
            color: Color(0xFF94A3B8),
          ),
        ),
      ],
    );
  }
  Widget _compareCard({
    required String title,
    required double value,
    required Color color,
    double? percent,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),

          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 9,
            ),
          ),

          SizedBox(height: 6),

          Text(
            "${value.toStringAsFixed(1)}",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 2),

          Text(
            "kWh",
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 12,
            ),
          ),

          if (percent != null) ...[
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 2,
              ),

              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
              ),

              child: Text(
                "↑ ${percent.toStringAsFixed(1)}%",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                  fontSize: 9,
                ),
              ),
            )
          ]
        ],
      ),
    );
  }
  Widget buildComparisonCard(
      List<EnergyReportResponse> data,
      ) {
    final currentTotal = data.fold(
      0.0,
          (a, b) => a + (selectedChart == 0 ? b.p : b.epi),
    );

    double previous = 0;

    final now = DateTime.now();

    for (final e in context.read<AnalyticsCubit>().state.data) {
      final d = e.time;

      final value =
      selectedChart == 0 ? e.p : e.epi;

      if (selectedRange == ChartRange.day) {
        final yesterday =
        now.subtract(Duration(days: 1));

        if (d.year == yesterday.year &&
            d.month == yesterday.month &&
            d.day == yesterday.day) {
          previous += value;
        }
      }

      else if (selectedRange == ChartRange.month) {
        final prevMonth =
        now.month == 1 ? 12 : now.month - 1;

        final prevYear =
        now.month == 1 ? now.year - 1 : now.year;

        if (d.year == prevYear &&
            d.month == prevMonth) {
          previous += value;
        }
      }

      else {
        if (d.year == now.year - 1) {
          previous += value;
        }
      }
    }

    final percent =
    previous == 0
        ? 0
        : ((currentTotal - previous) / previous) * 100;

    final positive = percent >= 0;

    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: Offset(0, 4),
          )
        ],
      ),

      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: positive
                  ? Colors.red.withOpacity(0.08)
                  : Colors.green.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),

            child: Icon(
              positive
                  ? Icons.trending_up
                  : Icons.trending_down,
              color: positive
                  ? Colors.red
                  : Colors.green,
            ),
          ),

          SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  positive
                      ? "Tiêu thụ tăng"
                      : "Tiêu thụ giảm",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  "${percent.abs().toStringAsFixed(1)}% so với kỳ trước",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          Text(
            "${currentTotal.toStringAsFixed(1)}",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
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
    if (data.isEmpty) {
      return Container(
        height: 240,
        alignment: Alignment.center,
        child: Text(
          "Không có dữ liệu",
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      );
    }

    final displayData = data;
    final now = DateTime.now();

    final yesterday = now.subtract(Duration(days: 1));

    final yesterdayData = applyRange(
      context.read<AnalyticsCubit>().state.data,
      ChartRange.day,
    ).where((e) {

      final d = e.time;

      return d.year == yesterday.year &&
          d.month == yesterday.month &&
          d.day == yesterday.day;

    }).toList();

    final yesterdayMap = <int, double>{};
    print("Yesterday count: ${yesterdayData.length}");
    for (final item in yesterdayData) {

      final key = selectedRange == ChartRange.day
          ? item.time.hour
          : item.time.day;

      yesterdayMap[key] =
      selectedChart == 0
          ? item.p
          : item.epi;
    }
    final rawValues = displayData.map<double>((e) {
      return selectedChart == 0 ? e.p : e.epi;
    }).toList();

    final maxRaw =
    rawValues.isEmpty ? 1.0 : rawValues.reduce((a, b) => a > b ? a : b);

    final scaleFactor = maxRaw < 10 ? 1000 : 1;

    final values = rawValues.map((e) => e * scaleFactor).toList();
    final sampledEntries = displayData.asMap().entries.where((e) {

      if (displayData.length <= 20) {
        return true;
      }

      return e.key % 2 == 0;

    }).toList();
    final max =
    values.isEmpty ? 1.0 : values.reduce((a, b) => a > b ? a : b);
    final safeMax = max == 0 ? 1 : max;
    final maxIndex = values.indexOf(max);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: math.max(
          sampledEntries.length * 40,
          MediaQuery.of(context).size.width,
        ),
        height: 260,
        child: isLineChart
            ? LineChart(
          LineChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval:
              safeMax <= 0 ? 1 : (safeMax / 4),
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
                  reservedSize: 32,
                  interval: 1,
                  getTitlesWidget: (value, _) {

                    final index = value.toInt();

                    if (index >= displayData.length) {
                      return SizedBox();
                    }

                    if (displayData.length > 20 &&
                        index % 2 != 0) {
                      return SizedBox();
                    }

                    final time = displayData[index].time;

                    String label = "";

                    switch (selectedRange) {

                      case ChartRange.day:
                        label = "${time.hour}h";
                        break;

                      case ChartRange.week:
                        label = "${time.day}/${time.month}";
                        break;

                      case ChartRange.month:
                        label = "${time.day}";
                        break;

                      case ChartRange.year:
                        label = "T${time.month}";
                        break;

                      default:
                        label = "${index + 1}";
                    }

                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    );
                  },
                ),
              ),

              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 50,
                  getTitlesWidget: (value, meta) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        (value / scaleFactor)
                            .toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            lineBarsData: [
              LineChartBarData(
                spots: sampledEntries.map((e) {

                  final value = (
                      selectedChart == 0
                          ? e.value.p
                          : e.value.epi
                  ) * scaleFactor;

                  return FlSpot(
                    e.key.toDouble(),
                    value,
                  );

                }).toList(),

                isCurved: true,
                curveSmoothness: 0.3,
                color: Color(0xFF2C5C85),
                barWidth: 3,

                dotData: FlDotData(
                  show: true,
                ),

                belowBarData: BarAreaData(
                  show: true,
                  color: Color(0xFF2C5C85)
                      .withOpacity(0.08),
                ),
              ),
            ],
          )
        )
              : BarChart(
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
            alignment: BarChartAlignment.spaceEvenly,
            maxY: safeMax * 1.2,
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: safeMax <= 0 ? 1 : (safeMax / 4),
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
                  reservedSize: 32,
                  interval: 1,
                  getTitlesWidget: (value, _) {

                    final index = value.toInt();

                    if (index >= displayData.length) {
                      return SizedBox();
                    }

                    // chỉ hiện số lẻ để đồng bộ với sampledEntries
                    if (displayData.length > 20 && index % 2 != 0) {
                      return SizedBox();
                    }

                    final time = displayData[index].time;

                    String label = "";

                    switch (selectedRange) {

                      case ChartRange.day:
                        label = "${time.hour}h";

                        if (time.minute != 0) {
                          label =
                          "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
                        }
                        break;

                      case ChartRange.week:
                        label = "${time.day}/${time.month}";
                        break;

                      case ChartRange.month:
                        label = "${time.day}";
                        break;

                      case ChartRange.year:
                        label = "T${time.month}";
                        break;

                      default:
                        label = "${index + 1}";
                    }

                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    );
                  },
                ),
              ),

              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 50,
                  getTitlesWidget: (value, meta) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        (value / scaleFactor).toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            barGroups: sampledEntries.map((e) {

              final originalIndex = e.key;
              final value = (
                  selectedChart == 0
                      ? e.value.p
                      : e.value.epi
              ) * scaleFactor;

              final item = e.value;
              final compareKey = selectedRange == ChartRange.day
                  ? item.time.hour
                  : item.time.day;

              final yesterdayValue =
                  (yesterdayMap[compareKey] ?? 0) * scaleFactor;

              return BarChartGroupData(
                x: originalIndex,
                barsSpace: 4,

                barRods: [


                  // hôm qua
                  BarChartRodData(
                    toY: yesterdayValue,
                    width: 8,
                    borderRadius: BorderRadius.circular(2),
                      color: Color(0xFF60A5FA),
                  ),


                  // hôm nay
                  BarChartRodData(
                    toY: value,
                    width: 8,
                    borderRadius: BorderRadius.circular(2),
                    color: originalIndex == maxIndex
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

          final diff =
              now.difference(
                DateTime(d.year, d.month, d.day),
              ).inDays;

          return diff <= 2;

        case ChartRange.month:

          final diffMonth =
              (now.year - d.year) * 12 +
                  (now.month - d.month);

          return diffMonth <= 2;

        case ChartRange.year:

          final diffYear =
              now.year - d.year;

          return diffYear <= 2;

        default:
          return true;
      }

    }).toList();

    filtered.sort(
          (a, b) => a.time.compareTo(b.time),
    );

    return filtered;
  }
  Widget buildCompareYearChart(
      List<EnergyReportResponse> rawData,
      ) {

    final now = DateTime.now();
    print("=========== ENERGY REPORT ===========");

    for (final item in rawData) {
      print(
          "${item.time} | p=${item.p} | epi=${item.epi}"
      );
    }
    final Map<String, List<double>> groupedData = {};

    List<String> legends = [];
    List<Color> colors = [
      Color(0xFFD32F2F),
      Color(0xFF388E3C),
      Color(0xFF1976D2),
    ];

    int maxX = 0;

    if (selectedRange == ChartRange.day) {

      legends = ["Hôm nay", "Hôm qua", "2 ngày trước"];
      maxX = 24;

      groupedData["Hôm nay"] = List.filled(24, 0);
      groupedData["Hôm qua"] = List.filled(24, 0);
      groupedData["2 ngày trước"] = List.filled(24, 0);

      for (final item in rawData) {

        final value =
        selectedChart == 0 ? item.p : item.epi;

        final d = item.time;

        final diff =
            now.difference(DateTime(d.year, d.month, d.day)).inDays;

        if (diff == 0) {
          groupedData["Hôm nay"]![d.hour] += value;
        }

        else if (diff == 1) {
          groupedData["Hôm qua"]![d.hour] += value;
        }

        else if (diff == 2) {
          groupedData["2 ngày trước"]![d.hour] += value;
        }
      }
    }

    else if (selectedRange == ChartRange.month) {

      legends = ["Tháng này", "Tháng trước", "2 tháng trước"];
      maxX = 31;

      groupedData["Tháng này"] = List.filled(31, 0);
      groupedData["Tháng trước"] = List.filled(31, 0);
      groupedData["2 tháng trước"] = List.filled(31, 0);

      for (final item in rawData) {

        final value =
        selectedChart == 0 ? item.p : item.epi;

        final d = item.time;

        final diffMonth =
            (now.year - d.year) * 12 + now.month - d.month;

        if (diffMonth == 0) {
          groupedData["Tháng này"]![d.day - 1] += value;
        }

        else if (diffMonth == 1) {
          groupedData["Tháng trước"]![d.day - 1] += value;
        }

        else if (diffMonth == 2) {
          groupedData["2 tháng trước"]![d.day - 1] += value;
        }
      }
    }

    else {

      legends = ["Tháng này", "Tháng trước", "2 tháng trước"];
      maxX = 31;

      groupedData["Tháng này"] = List.filled(31, 0);
      groupedData["Tháng trước"] = List.filled(31, 0);
      groupedData["2 tháng trước"] = List.filled(31, 0);

      for (final item in rawData) {
        final value = selectedChart == 0 ? item.p : item.epi;
        final d = item.time;

        final diffMonth =
            (now.year - d.year) * 12 +
                (now.month - d.month);

        if (diffMonth == 0) {
          groupedData["Tháng này"]![d.day - 1] += value;
        } else if (diffMonth == 1) {
          groupedData["Tháng trước"]![d.day - 1] += value;
        } else if (diffMonth == 2) {
          groupedData["2 tháng trước"]![d.day - 1] += value;
        }
      }
    }

    double maxY = 0;

    for (final list in groupedData.values) {
      for (final v in list) {
        if (v > maxY) {
          maxY = v;
        }
      }
    }

    return Column(
      children: [

        Wrap(
          spacing: 16,
          children: legends.asMap().entries.map((e) {

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [

                Container(
                  width: 10,
                  height: 10,
                  color: colors[e.key],
                ),

                SizedBox(width: 6),

                Text(
                  e.value,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            );
          }).toList(),
        ),

        SizedBox(height: 20),

        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: maxX * 44,
              child: BarChart(
                BarChartData(

                  alignment: BarChartAlignment.center,

                  groupsSpace: 12,

                  maxY: maxY * 1.2,

                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                  ),

                  borderData: FlBorderData(show: false),

                  titlesData: FlTitlesData(

                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),

                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),

                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 46,
                      ),
                    ),

                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: (value, meta) {

                          Widget child;

                          if (selectedRange == ChartRange.day) {
                            child = Text("${value.toInt()}h");
                          } else {
                            child = Text("${value.toInt() + 1}");
                          }

                          return Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: child,
                          );
                        },
                      ),
                    ),
                  ),

                  barGroups: List.generate(maxX, (index) {

                    return BarChartGroupData(
                      x: index,

                      barsSpace: 3,

                      barRods: legends.asMap().entries.map((e) {

                        final values = groupedData[e.value]!;

                        return BarChartRodData(
                          toY: values[index],
                          width: 10,
                          color: colors[e.key],
                          borderRadius: BorderRadius.circular(2),
                        );

                      }).toList(),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ],
    );
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
                  buildMainTabs(),
                  SizedBox(height: 12),

                  if (selectedTab == 0) ...[
                    buildFilterBar(),
                    SizedBox(height: 12),

                    buildTabs(),
                    SizedBox(height: 12),

                    buildHeader(data),
                    SizedBox(height: 12),
                    buildComparisonCard(data),
                    SizedBox(height: 12),
                    buildCompareCards(data),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [

                              Text(
                                selectedChart == 0
                                    ? "Power (kW)"
                                    : "Energy (kWh)",
                              ),

                              SizedBox(
                                width: 120,
                                child: buildChartTypeToggle(),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          buildChart(data),

                          SizedBox(height: 12),

                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Builder(
                                  builder: (_) {

                                    final years = state.data
                                        .map((e) => e.time.year)
                                        .toSet();

                                    final title = years.length <= 1
                                        ? "Sản lượng theo tháng"
                                        : "So sánh sản lượng theo năm";

                                    return Text(
                                      title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    );
                                  },
                                ),

                                SizedBox(height: 16),

                                SizedBox(
                                  height: 380,
                                  child: buildCompareYearChart(
                                    context.read<AnalyticsCubit>().state.data,
                                  ),
                                ),
                              ],

                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 12),
                    buildPremiumBlock(data),
                  ] else ...[
                    buildChartTypeToggle(),
                    SizedBox(height: 12),

                    buildMCBCharts(state.breakerData ?? []),
                  ],
                ]
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