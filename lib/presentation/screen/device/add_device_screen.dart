import 'package:flutter/material.dart';
import 'package:solar_energy/data/dto/electric/response/electric_meter_response.dart';
import 'package:solar_energy/data/data_sources/api/api_client.dart';
import 'package:get_it/get_it.dart';

class AddDeviceScreen extends StatefulWidget {
  final int powerStationId;
  final int meterId;

  const AddDeviceScreen({
    super.key,
    required this.powerStationId,
    required this.meterId,
  });

  @override
  State<AddDeviceScreen> createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen>
    with SingleTickerProviderStateMixin {
  late Future<ElectricMeter?> future;
  late TabController _tabController;

  final _api = GetIt.instance<ApiClient>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    future = _loadData();
  }

  /// ================= LOAD DATA THẬT =================
  Future<ElectricMeter?> _loadData() async {
    final response = await _api.getElectric(widget.powerStationId);
    final meters = response.data;

    try {
      return meters.firstWhere(
              (e) => e.meter.id == widget.meterId);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chi tiết thiết bị')),
      body: FutureBuilder<ElectricMeter?>(
        future: future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator());
          }

          final electric = snapshot.data;
          if (electric == null) {
            return const Center(
                child: Text('Không tìm thấy thiết bị'));
          }

          return _buildContent(electric);
        },
      ),
    );
  }

  Widget _buildContent(ElectricMeter electric) {
    final log = electric.lastedLogData;
    final meter = electric.meter;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _header(meter.name ?? '', log.status),
        const SizedBox(height: 20),
        _deviceInfoCard(meter, log),
        const SizedBox(height: 12),
        _energySummary(log),
        const SizedBox(height: 12),
        _realtimeSection(log),
        const SizedBox(height: 16),
        _tabs(),
        const SizedBox(height: 12),
        _tabContent(),
      ],
    );
  }

  Widget _header(String name, int status) {
    return Column(
      children: [
        const Icon(Icons.electrical_services, size: 72),
        const SizedBox(height: 8),
        Text(name,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.circle,
                size: 10,
                color:
                status == 1 ? Colors.green : Colors.red),
            const SizedBox(width: 6),
            Text(status == 1
                ? 'Đang hoạt động'
                : 'Ngoại tuyến'),
          ],
        ),
      ],
    );
  }

  Widget _deviceInfoCard(meter, log) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            _infoRow('Tên thiết bị', meter.name ?? ''),
            _infoRow('Mã thiết bị', meter.code ?? ''),
            _infoRow(
                'Trạng thái',
                log.status == 1
                    ? 'Hoạt động'
                    : 'Tắt'),
            _infoRow(
                'Thời gian cập nhật',
                log.updateTime?.toString() ?? ''),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(label,
                style: const TextStyle(
                    color: Colors.grey)),
          ),
          Expanded(
            flex: 6,
            child: Text(value,
                style: const TextStyle(
                    fontWeight:
                    FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _energySummary(log) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics:
          const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 2.4,
          children: [
            _energyTile(
                'Điện áp TB',
                '${_avg(log.paramUa, log.paramUb, log.paramUc)} V',
                Colors.blue),
            _energyTile(
                'Dòng điện TB',
                '${_avg(log.paramIa, log.paramIb, log.paramIc)} A',
                Colors.orange),
            _energyTile(
                'Công suất (P)',
                '${log.paramP} kW',
                Colors.purple),
            _energyTile(
                'Công suất phản kháng (Q)',
                '${log.paramQ} kVAR',
                Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _energyTile(
      String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius:
        BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey)),
          const SizedBox(height: 6),
          Text(value,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight:
                  FontWeight.bold,
                  color: color)),
        ],
      ),
    );
  }

  Widget _realtimeSection(log) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics:
          const NeverScrollableScrollPhysics(),
          childAspectRatio: 2.4,
          children: [
            _metric('Ua', '${log.paramUa} V'),
            _metric('Ub', '${log.paramUb} V'),
            _metric('Uc', '${log.paramUc} V'),
            _metric('Ia', '${log.paramIa} A'),
            _metric('Ib', '${log.paramIb} A'),
            _metric('Ic', '${log.paramIc} A'),
          ],
        ),
      ),
    );
  }

  Widget _metric(String label, String value) {
    return Column(
      mainAxisAlignment:
      MainAxisAlignment.center,
      children: [
        Text(value,
            style: const TextStyle(
                fontWeight:
                FontWeight.bold,
                fontSize: 14)),
        const SizedBox(height: 2),
        Text(label,
            style: const TextStyle(
                color: Colors.grey,
                fontSize: 11)),
      ],
    );
  }

  String _avg(String a, String b, String c) {
    try {
      final v =
          (double.parse(a) +
              double.parse(b) +
              double.parse(c)) /
              3;
      return v.toStringAsFixed(1);
    } catch (_) {
      return '0';
    }
  }

  Widget _tabs() {
    return TabBar(
      controller: _tabController,
      tabs: const [
        Tab(text: 'Thông tin cảnh báo'),
        Tab(text: 'Bản lưu điều khiển'),
      ],
    );
  }

  Widget _tabContent() {
    return SizedBox(
      height: 80,
      child: TabBarView(
        controller: _tabController,
        children: const [
          Center(child: Text('Chưa có cảnh báo')),
          Center(child: Text('Chưa có bản lưu')),
        ],
      ),
    );
  }
}
