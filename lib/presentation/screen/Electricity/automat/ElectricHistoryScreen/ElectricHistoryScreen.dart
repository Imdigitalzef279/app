// ================= IMPORT =================
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../data/data_sources/api/api_client.dart';
import '../../../../../data/dto/device/response/device_response.dart';
import '../../../../../data/dto/electric_report/electric_report_response.dart';
import '../../../../../data/dto/energy_report/energy_report_response.dart';
import '../../../../../data/dto/power_station/response/power_station_response.dart';
import '../../../../../data/repositories/EnergyRepository/EnergyRepository.dart';

class EnergyState {
  final List<EnergyReportResponse> chart;
  final ElectricReport report;

  EnergyState({
    required this.chart,
    required this.report,
  });
}
class ElectricHistoryCubit extends Cubit<EnergyState?> {
  final EnergyRepository repo;

  ElectricHistoryCubit(this.repo) : super(null);

  Future<void> load({
    required int stationId,
    required int deviceId,
    required int meterId,
    required DateTime from,
    required DateTime to,
  }) async {

    final chart = await repo.getByDateRange(
      stationId: stationId,
      deviceId: deviceId,
      from: from,
      to: to,
    );

    final report = await repo.getElectricReport(
      meterId: meterId,
      from: from,
      to: to,
    );

    emit(EnergyState(chart: chart, report: report));
  }
}
/// ================= SCREEN =================
class ElectricHistoryScreen extends StatefulWidget {
  final DeviceResponse device;

  const ElectricHistoryScreen({super.key, required this.device});

  @override
  State<ElectricHistoryScreen> createState() =>
      _ElectricHistoryScreenState();
}

class _ElectricHistoryScreenState extends State<ElectricHistoryScreen> {

  int selectedIndex = 1; // 0=7d,1=30d,2=90d
  DateTime focusedDay = DateTime.now();
  DateTime? startDate;
  DateTime? endDate;
  DateTimeRange get range {
    final now = DateTime.now();
    if (selectedIndex == 0) {
      return DateTimeRange(start: now.subtract(const Duration(days: 7)), end: now);
    }
    if (selectedIndex == 1) {
      return DateTimeRange(start: now.subtract(const Duration(days: 30)), end: now);
    }
    return DateTimeRange(start: now.subtract(const Duration(days: 90)), end: now);
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = ElectricHistoryCubit(
          EnergyRepository(GetIt.instance<ApiClient>()),
        );

        cubit.load(
          stationId: widget.device.powerStationId ?? 0,
          deviceId: widget.device.id,
          meterId: widget.device.id,
          from: range.start,
          to: range.end,
        );

        return cubit;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F8FC),
        appBar: AppBar(
          title: const Text("Lịch sử tiêu thụ điện"),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              _filter(),

              const SizedBox(height: 16),


              Expanded(
                child: BlocBuilder<ElectricHistoryCubit, EnergyState?>(
                  builder: (context, state) {

                    if (state == null) {
                      return _emptyState();
                    }

                    return ListView(
                      children: [
                        _summary(state.report),
                        const SizedBox(height: 16),
                        _chart(state.chart),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  DateTimeRange? selectedRange;
  List<PowerStationResponse> stations = [];
  List<DeviceResponse> devices = [];

  PowerStationResponse? selectedStation;
  DeviceResponse? selectedDevice;
  Widget _filter() {
    return Column(
      children: [

        /// ROW 1
        Row(
          children: [
            Expanded(
              child: _dropdown<PowerStationResponse>(
                hint: "Trạm",
                value: selectedStation,
                items: stations,
                getLabel: (e) => e.name ?? "",
                onChanged: (v) {
                  setState(() {
                    selectedStation = v;
                    selectedDevice = null;
                  });

                  if (v != null) {
                    _loadDevices(v.id);
                  }
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _dropdown<DeviceResponse>(
                hint: "Thiết bị",
                value: selectedDevice,
                items: devices,
                getLabel: (e) => e.name ?? "",
                onChanged: (v) {
                  setState(() {
                    selectedDevice = v;
                  });
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        /// ROW 2
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: _pickDate,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          selectedRange == null
                              ? "Chọn thời gian"
                              : "${DateFormat('dd/MM/yyyy').format(selectedRange!.start)} - "
                              "${DateFormat('dd/MM/yyyy').format(selectedRange!.end)}",
                          style: TextStyle(
                            color: selectedRange == null
                                ? Colors.grey
                                : Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(width: 10),

            GestureDetector(
              onTap: _search,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF1ABC9C),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.search, color: Colors.white),
              ),
            )
          ],
        )
      ],
    );
  }
  @override
  void initState() {
    super.initState();

    selectedRange = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 7)),
      end: DateTime.now(),
    );

    _loadStations();
  }
  Future<void> _loadStations() async {
    final res = await GetIt.instance<ApiClient>()
        .getPowerStation(1);

    setState(() {
      stations = res;
    });
  }
  Future<void> _loadDevices(int stationId) async {
    final res = await GetIt.instance<ApiClient>()
        .getDevices(stationId);

    setState(() {
      devices = res;
    });
  }
  Future<void> _pickDate() async {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return StatefulBuilder(
              builder: (context, setStateModal) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      const Text(
                        "Chọn khoảng thời gian",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 10),

                      /// CALENDAR
                      TableCalendar(
                        firstDay: DateTime(2020),
                        lastDay: DateTime(2100),
                        focusedDay: focusedDay,

                        rangeStartDay: startDate,
                        rangeEndDay: endDate,
                        rangeSelectionMode: RangeSelectionMode.toggledOn,

                        onRangeSelected: (start, end, focused) {
                          setStateModal(() {
                            startDate = start;
                            endDate = end;
                            focusedDay = focused;
                          });
                        },

                        calendarStyle: const CalendarStyle(
                          todayDecoration: BoxDecoration(
                            color: Color(0xFF1ABC9C),
                            shape: BoxShape.circle,
                          ),

                          rangeHighlightColor: Color(0x331ABC9C),
                          rangeStartDecoration: BoxDecoration(
                            color: Color(0xFF1ABC9C),
                            shape: BoxShape.circle,
                          ),
                          rangeEndDecoration: BoxDecoration(
                            color: Color(0xFF1ABC9C),
                            shape: BoxShape.circle,
                          ),

                          defaultTextStyle: TextStyle(color: Colors.black),
                          weekendTextStyle: TextStyle(color: Colors.black),
                          outsideTextStyle: TextStyle(color: Colors.black),
                          disabledTextStyle: TextStyle(color: Colors.black),
                        ),

                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// BUTTON
                      ElevatedButton(
                        onPressed: () {
                          if (startDate != null && endDate != null) {
                            setState(() {
                              selectedRange = DateTimeRange(
                                start: startDate!,
                                end: endDate!,
                              );
                            });
                          }
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1ABC9C),
                        ),
                        child: const Text("Áp dụng"),
                      )
                    ],
                  ),
                );
              });
        }
    );
  }
  void _search() {
    if (selectedRange == null || selectedDevice == null) return;

    context.read<ElectricHistoryCubit>().load(
      stationId: selectedStation!.id,
      deviceId: selectedDevice!.id,
      meterId: selectedDevice!.id,
      from: selectedRange!.start,
      to: selectedRange!.end,
    );
  }

  String _f(DateTime d) => "${d.day}/${d.month}/${d.year}";
  Widget _dropdown<T>({
    required String hint,
    required T? value,
    required List<T> items,
    required String Function(T) getLabel,
    required Function(T?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          hint: Text(hint),
          value: value,
          isExpanded: true,
          items: items.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(getLabel(e)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }


  /// ================= SUMMARY =================
  Widget _summary(ElectricReport report) {
    final tou = report.tou;

    final total = tou.totalKwh;

    final low = tou.lowKwh;
    final mid = tou.midKwh;
    final high = tou.highKwh;

    final double percent = total == 0 ? 0.0 : (mid / total);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text("Tổng tiêu thụ"),

          Text(
            "${NumberFormat("#,###").format(tou.totalWithVat)} đ",
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          Text("${tou.totalKwh.toStringAsFixed(2)} kWh"),

          const SizedBox(height: 20),

          Row(
            children: [

              /// circle
              SizedBox(
                width: 90,
                height: 90,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: percent,
                      strokeWidth: 8,
                    ),
                    Text("${(percent * 100).toStringAsFixed(0)}%"),
                  ],
                ),
              ),

              const SizedBox(width: 20),

              Expanded(
                child: Column(
                  children: [
                    _energyItem("Thấp điểm", low, Colors.blue),
                    _energyItem("Trung bình", mid, Colors.orange),
                    _energyItem("Cao điểm", high, Colors.green),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
  Widget _energyItem(String title, double value, Color color) {
    return Row(
      children: [

        /// màu
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),

        const SizedBox(width: 8),

        /// text
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 12),
          ),
        ),

        /// value
        Text(
          "${value.toStringAsFixed(2)} kWh",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
  /// ==============  === CHART =================
  Widget _chart(List<EnergyReportResponse> data) {
    if (data.isEmpty) return _emptyState();

    data.sort((a, b) => a.time.compareTo(b.time));

    double sum = 0;

    final spots = data.asMap().entries.map((e) {
      sum += e.value.epi;

      return FlSpot(
        e.key.toDouble(),
        sum,
      );
    }).toList();
    final minY = spots.map((e) => e.y).reduce((a, b) => a < b ? a : b);
    final maxY2 = spots.map((e) => e.y).reduce((a, b) => a > b ? a : b);
    final maxY = (data.map((e) => e.epi).reduce((a, b) => a > b ? a : b) * 1.2)
        .ceilToDouble();

    return Container(
      height: 280,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(24),
      ),
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: spots.length.toDouble() - 1,
          minY: minY * 0.995,
          maxY: maxY2 * 1.005,

          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Colors.white.withOpacity(0.05),
              strokeWidth: 1,
            ),
          ),

          borderData: FlBorderData(show: false),

          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 36,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toStringAsFixed(0),
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white38,
                    ),
                  );
                },
              ),
            ),

            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: (spots.length / 5).ceilToDouble(),
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();

                  if (index < 0 || index >= data.length) {
                    return const SizedBox();
                  }

                  final date = data[index].time;

                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      "${date.day}/${date.month}",
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white38,
                      ),
                    ),
                  );
                },
              ),
            ),

            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),

          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: Colors.black87,
              getTooltipItems: (spots) {
                return spots.map((spot) {
                  final date = data[spot.x.toInt()].time;

                  return LineTooltipItem(
                    "${date.day}/${date.month}\n",
                    const TextStyle(color: Colors.grey, fontSize: 10),
                    children: [
                      TextSpan(
                        text: "${spot.y.toStringAsFixed(2)} kWh",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                }).toList();
              },
            ),
          ),

          lineBarsData: [
            LineChartBarData(
              spots: spots,
              curveSmoothness: 0.8,
              isCurved: true,
              barWidth: 2,
              gradient: const LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF60A5FA)],
              ),
          dotData: FlDotData(show: false,
                getDotPainter: (spot, percent, bar, index) {
                  return FlDotCirclePainter(
                    radius: 3,
                    color: Colors.orange,
                    strokeWidth: 0,
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFFF7A18).withOpacity(0.3),
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.insert_chart_outlined, size: 60, color: Colors.grey),
          SizedBox(height: 10),
          Text("Chưa có dữ liệu"),
        ],
      ),
    );
  }
}