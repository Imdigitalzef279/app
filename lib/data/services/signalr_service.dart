import 'package:signalr_core/signalr_core.dart';

class SignalRService {
  HubConnection? _connection;

  Future<void> connect({
    required String meterCode,
    required Function(Map<String, dynamic>) onData,
  }) async {
    print("🔵 Start connect SignalR");

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

    // ===== Connection lifecycle =====
    _connection!.onclose((error) {
      print("🔴 Connection closed: $error");
    });

    _connection!.onreconnecting((error) {
      print("🟡 Reconnecting...");
    });

    _connection!.onreconnected((connectionId) {
      print("🟢 Reconnected: $connectionId");
    });

    // ================= LISTEN ALL POSSIBLE EVENTS =================

    void handleEvent(String eventName, List<Object?>? data) {
      print("🔥 EVENT [$eventName] => $data");

      if (data != null && data.isNotEmpty) {
        try {
          final payload = Map<String, dynamic>.from(data.first as Map);
          onData(payload);
        } catch (e) {
          print("❌ Parse error: $e");
        }
      }
    }

    _connection!.on("ReceiveLog", (data) {
      print("⚡ ReceiveLog EVENT: $data");

      if (data != null && data.isNotEmpty) {
        final payload = Map<String, dynamic>.from(data.first);
        onData(payload);
      }
    });


    // ===============================================================

    await _connection!.start();
    print("🟢 SignalR Connected");

    await _connection!.invoke("JoinMeter", args: [meterCode]);
    print("🟢 Joined meter: $meterCode");
  }

  Future<void> disconnect() async {
    await _connection?.stop();
    print("🔴 SignalR Disconnected");
  }
}