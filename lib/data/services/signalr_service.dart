import 'dart:async';
import 'dart:convert';
import 'package:signalr_core/signalr_core.dart';

enum SignalRStatus {
  disconnected,
  connecting,
  connected,
  reconnecting,
}

class SignalRService {
  static final SignalRService _instance = SignalRService._internal();
  factory SignalRService() => _instance;
  SignalRService._internal();

  HubConnection? _connection;
  SignalRStatus _status = SignalRStatus.disconnected;

  String? _currentMeterCode;

  final StreamController<Map<String, dynamic>> _dataController =
  StreamController.broadcast();

  final StreamController<SignalRStatus> _statusController =
  StreamController.broadcast();

  Stream<Map<String, dynamic>> get stream => _dataController.stream;
  Stream<SignalRStatus> get statusStream => _statusController.stream;

  SignalRStatus get currentStatus => _status;

  bool get isConnected =>
      _connection?.state == HubConnectionState.connected;

  bool get isConnecting =>
      _connection?.state == HubConnectionState.connecting;

  // ================= CONNECT =================
  Future<void> connect({
    required String meterCode,
  }) async {
    if (isConnected || isConnecting) return;

    _currentMeterCode = meterCode;

    _updateStatus(SignalRStatus.connecting);

    _connection = HubConnectionBuilder()
        .withUrl(
      "https://krapower.vn/signalr-logmeter",
      HttpConnectionOptions(
        transport: HttpTransportType.webSockets,
      ),
    )
        .withAutomaticReconnect()
        .build();

    _registerLifecycle();
    _registerEvents();

    await _connection!.start();

    await _joinMeter();

    _updateStatus(SignalRStatus.connected);
    print("🟢 SignalR Connected");
  }

  // ================= JOIN =================
  Future<void> _joinMeter() async {
    if (_currentMeterCode == null) return;

    try {
      print("🔥🔥🔥 JOIN METER: $_currentMeterCode 🔥🔥🔥");

      await _connection!.invoke("JoinMeter", args: [_currentMeterCode]);

      print("🟢 Joined meter: $_currentMeterCode");
    } catch (e) {
      print("❌ JoinMeter error: $e");
    }
  }

  // ================= EVENTS =================
  void _registerEvents() {
    void listenEvent(String eventName, List<Object?>? data) {
      if (data == null || data.isEmpty) return;

      final raw = data.first;

      try {
        Map<String, dynamic> payload;

        if (raw is String) {
          payload = jsonDecode(raw);
        } else if (raw is Map) {
          payload = Map<String, dynamic>.from(raw);
        } else {
          return;
        }

        payload["event"] = eventName;

        _dataController.add(payload);
      } catch (e) {

      }
    }

    _connection!.on("ReceiveLog",
            (data) => listenEvent("ReceiveLog", data));

    _connection!.on("ReceiveChart",
            (data) => listenEvent("ReceiveChart", data));

    _connection!.on("ReceiveCommand", (data) {

      listenEvent("ReceiveCommand", data);
    });
  }

  // ================= LIFECYCLE =================
  void _registerLifecycle() {
    _connection!.onclose((error) {

      _updateStatus(SignalRStatus.disconnected);
    });

    _connection!.onreconnecting((error) {

      _updateStatus(SignalRStatus.reconnecting);
    });

    _connection!.onreconnected((connectionId) async {


      await _joinMeter(); // 🔥 QUAN TRỌNG

      _updateStatus(SignalRStatus.connected);
    });
  }

  // ================= DISCONNECT =================
  Future<void> disconnect() async {
    if (_connection == null) return;

    await _connection!.stop();
    _connection = null;

    _updateStatus(SignalRStatus.disconnected);
    print("🔴 SignalR Disconnected");
  }

  // ================= STATUS =================
  void _updateStatus(SignalRStatus newStatus) {
    _status = newStatus;
    _statusController.add(newStatus);
  }

  void dispose() {
    _dataController.close();
    _statusController.close();
  }
}