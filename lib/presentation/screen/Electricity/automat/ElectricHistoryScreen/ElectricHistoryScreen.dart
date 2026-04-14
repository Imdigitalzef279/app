
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

    emit(EnergyState(
      chart: chart,
      report: report,
    ));
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

  int selectedIndex = 1;
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

        final r = selectedRange ?? range;

        cubit.load(
          stationId: widget.device.powerStationId ?? 0,
          deviceId: widget.device.id,
          meterId: widget.device.id,
          from: r.start,
          to: r.end,
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

              _header(),
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
                        _touTable(state.report),
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

  Widget _touTable(ElectricReport report) {

    if (report.type == "TIER") {
      final tiers = report.tiers;

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Chi tiết bậc thang",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Row(
              children: const [
                Expanded(child: Text("Bậc")),
                Expanded(child: Text("Đơn giá")),
                Expanded(child: Text("kWh")),
                Expanded(child: Text("Thành tiền")),
              ],
            ),

            const Divider(),

            ...tiers.map((e) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Expanded(child: Text("Bậc ${e.stepOrder}")),
                    Expanded(child: Text("${e.price}")),
                    Expanded(child: Text("${e.kwhInStep}")),
                    Expanded(child: Text(
                      NumberFormat("#,###").format(e.stepCost),
                    )),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      );
    }


    final tou = report.tou!;

    final vat = tou.totalWithVat - tou.totalCost;
    double total = tou.totalKwh;

    double percent(double v) => total == 0 ? 0 : (v / total * 100);

    Widget row(
        String name,
        double price,
        double kwh,
        double money,
        ) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Expanded(flex: 2, child: Text(name)),
            Expanded(child: Text(NumberFormat("#,###").format(price))),

            Expanded(child: Text(kwh.toStringAsFixed(0))),
            Expanded(child: Text(NumberFormat("#,###").format(money))),
            Expanded(child: Text("${percent(kwh).toStringAsFixed(2)}%")),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text("Chi tiết tiêu thụ",
              style: TextStyle(fontWeight: FontWeight.bold)),

          const SizedBox(height: 10),

          Row(
            children: const [
              Expanded(flex: 2, child: Text("Khung giờ")),
              Expanded(child: Text("Đơn giá")),
              Expanded(child: Text("kWh")),
              Expanded(child: Text("Thành tiền")),
              Expanded(child: Text("%")),
            ],
          ),

          const Divider(),

          row("Thấp điểm", tou.lowPrice, tou.lowKwh, tou.lowCost),
          row("Trung bình", tou.midPrice, tou.midKwh, tou.midCost),
          row("Cao điểm", tou.highPrice, tou.highKwh, tou.highCost),

          const Divider(),

          row("Tổng", 0, tou.totalKwh, tou.totalCost),

          const SizedBox(height: 6),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("VAT (8%)"),
              Text(NumberFormat("#,###").format(vat)),
            ],
          ),

          const SizedBox(height: 6),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Tổng (gồm VAT)",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                NumberFormat("#,###").format(tou.totalWithVat),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
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

  Widget _header() {
    final r = selectedRange ?? range;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [

          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF1ABC9C).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.electric_bolt, color: Color(0xFF1ABC9C)),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.device.name ?? "",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${DateFormat('dd/MM/yyyy').format(r.start)} - "
                      "${DateFormat('dd/MM/yyyy').format(r.end)}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (_) => _calendarPicker(),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.calendar_today, size: 18),
            ),
          )
        ],
      ),
    );
  }
  Widget _calendarPicker() {
    DateTime? start = selectedRange?.start;
    DateTime? end = selectedRange?.end;

    return StatefulBuilder(
      builder: (context, setStateModal) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                /// ===== TITLE =====
                const Text(
                  "Chọn khoảng ngày",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 12),

                /// ===== CALENDAR =====
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TableCalendar(
                    firstDay: DateTime(2020),
                    lastDay: DateTime.now(),
                    focusedDay: focusedDay,

                    rangeStartDay: start,
                    rangeEndDay: end,
                    rangeSelectionMode: RangeSelectionMode.enforced,

                    onRangeSelected: (s, e, _) {
                      setStateModal(() {
                        start = s;
                        end = e;
                      });
                    },

                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      leftChevronIcon: const Icon(Icons.chevron_left),
                      rightChevronIcon: const Icon(Icons.chevron_right),
                      titleTextStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle: TextStyle(color: Colors.grey),
                      weekendStyle: TextStyle(color: Colors.grey),
                    ),

                    calendarStyle: CalendarStyle(
                      outsideDaysVisible: false,

                      defaultTextStyle: const TextStyle(fontSize: 14),

                      weekendTextStyle: const TextStyle(color: Colors.black),

                      todayDecoration: BoxDecoration(
                        color: const Color(0xFF1ABC9C).withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),

                      selectedDecoration: const BoxDecoration(
                        color: Color(0xFF1ABC9C),
                        shape: BoxShape.circle,
                      ),

                      rangeStartDecoration: const BoxDecoration(
                        color: Color(0xFF1ABC9C),
                        shape: BoxShape.circle,
                      ),

                      rangeEndDecoration: const BoxDecoration(
                        color: Color(0xFF1ABC9C),
                        shape: BoxShape.circle,
                      ),

                      rangeHighlightColor:
                      const Color(0xFF1ABC9C).withOpacity(0.15),

                      withinRangeTextStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                /// ===== BUTTON =====
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1ABC9C),
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (start != null && end != null) {
                      Navigator.pop(context);

                      setState(() {
                        selectedRange = DateTimeRange(
                          start: start!,
                          end: end!,
                        );
                      });

                      context.read<ElectricHistoryCubit>().load(
                        stationId: widget.device.powerStationId ?? 0,
                        deviceId: widget.device.id,
                        meterId: widget.device.id,
                        from: start!,
                        to: end!,
                      );
                    }
                  },
                  child: const Text(
                    "Áp dụng",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _summary(ElectricReport report) {


    if (report.type == "TIER") {
      final tiers = report.tiers;

      final totalKwh = tiers.fold<double>(
        0,
            (sum, e) => sum + e.kwhInStep,
      );

      final totalMoney = tiers.fold<double>(
        0,
            (sum, e) => sum + e.stepCost,
      );
      return Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Tổng tiêu thụ",
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),

            const SizedBox(height: 12),

            Text(
              "${NumberFormat("#,###").format(totalMoney)} đ",
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              "${totalKwh.toStringAsFixed(2)} kWh",
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    final tou = report.tou!;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "Tổng tiêu thụ",
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),

          const SizedBox(height: 12),

          Row(
            children: [

              Expanded(
                flex: 2,
                child: Text(
                  "${NumberFormat("#,###").format(tou.totalWithVat)} đ",
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Expanded(
                flex: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _energyInline("Thấp", tou.lowKwh, Colors.blue),
                    _energyInline("Trung", tou.midKwh, Colors.orange),
                    _energyInline("Cao", tou.highKwh, Colors.green),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          Text(
            "${tou.totalKwh.toStringAsFixed(2)} kWh",
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
  Widget _energyInline(String title, double value, Color color) {
    return Row(
      children: [

        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),

        const SizedBox(width: 4),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 10),
            ),
            Text(
              value.toStringAsFixed(2),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ],
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