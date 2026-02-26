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
  // ================= SINGLETON =================
  static final SignalRService _instance = SignalRService._internal();
  factory SignalRService() => _instance;
  SignalRService._internal();

  // ================= VARIABLES =================
  HubConnection? _connection;
  SignalRStatus _status = SignalRStatus.disconnected;

  final StreamController<Map<String, dynamic>> _dataController =
  StreamController.broadcast();

  final StreamController<SignalRStatus> _statusController =
  StreamController.broadcast();

  Stream<Map<String, dynamic>> get stream => _dataController.stream;
  Stream<SignalRStatus> get statusStream => _statusController.stream;

  SignalRStatus get currentStatus => _status;

  bool get isConnected =>
      _connection?.state == HubConnectionState.connected;

  // ================= CONNECT =================
  Future<void> connect({
    required String meterCode,
    Function(Map<String, dynamic>)? onData,
  }) async {
    if (isConnected) return;

    _updateStatus(SignalRStatus.connecting);

    _connection = HubConnectionBuilder()
        .withUrl(
      "https://krapower.vn/signalr-logmeter",
      HttpConnectionOptions(
        skipNegotiation: false,
        transport: HttpTransportType.webSockets,
      ),
    )
        .withAutomaticReconnect()
        .build();

    _registerLifecycle();

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

        // 🔥 giữ logic cũ
        if (onData != null) {
          onData(payload);
        }

        // 🔥 vẫn push stream cho màn khác nếu cần
        _dataController.add(payload);
      } catch (e) {
        print("Parse error: $e");
      }
    }

    _connection!.on("ReceiveLog", (data) {
      print("🔥 ReceiveLog RAW: $data");
      listenEvent("ReceiveLog", data);
    });

    _connection!.on("ReceiveChart", (data) {
      print("🔥 ReceiveChart RAW: $data");
      listenEvent("ReceiveChart", data);
    });

    _connection!.on("ReceiveCommand", (data) {
      print("🔥 ReceiveCommand RAW: $data");
      listenEvent("ReceiveCommand", data);
    });

    await _connection!.start();
    _updateStatus(SignalRStatus.connected);
    print("🟢 SignalR Connected");
    await _connection!.invoke("JoinMeter", args: [meterCode]);
    print("🟢 Joined meter: $meterCode");
  }

  // ================= LIFECYCLE =================
  void _registerLifecycle() {
    _connection!.onclose((error) {
      print("🔴 Connection closed: $error");
      _updateStatus(SignalRStatus.disconnected);
    });

    _connection!.onreconnecting((error) {
      print("🟡 Reconnecting...");
      _updateStatus(SignalRStatus.reconnecting);
    });

    _connection!.onreconnected((connectionId) {
      print("🟢 Reconnected: $connectionId");
      _updateStatus(SignalRStatus.connected);
    });
  }

  // ================= EVENTS =================
  void _registerEvents() {
    void listenEvent(String eventName, List<Object?>? data) {
      print("🔥 [$eventName] RAW => $data");

      if (data == null || data.isEmpty) return;

      final raw = data.first;

      try {
        Map<String, dynamic> payload;

        if (raw is String) {
          payload = jsonDecode(raw);
        } else if (raw is Map) {
          payload = Map<String, dynamic>.from(raw);
        } else {
          print("⚠ Unknown data type: ${raw.runtimeType}");
          return;
        }

        payload["event"] = eventName;
        payload["timestamp"] = DateTime.now().toIso8601String();

        _dataController.add(payload);
      } catch (e) {
        print("❌ [$eventName] Parse error: $e");
      }
    }

    _connection!.on("ReceiveLog", (data) {
      listenEvent("ReceiveLog", data);
    });

    _connection!.on("ReceiveChart", (data) {
      listenEvent("ReceiveChart", data);
    });

    _connection!.on("ReceiveCommand", (data) {
      listenEvent("ReceiveCommand", data);
    });
  }

  // ================= DISCONNECT =================
  Future<void> disconnect() async {
    if (_connection == null) return;

    try {
      await _connection!.stop();
      print("🔴 SignalR Disconnected");
    } catch (e) {
      print("❌ Disconnect error: $e");
    }

    _updateStatus(SignalRStatus.disconnected);
  }

  // ================= STATUS =================
  void _updateStatus(SignalRStatus newStatus) {
    _status = newStatus;
    _statusController.add(newStatus);
  }

  // ================= DISPOSE (OPTIONAL) =================
  void dispose() {
    _dataController.close();
    _statusController.close();
  }
}