import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/signalr_service.dart';
import '../../data/dto/atomat/atomat_log_response.dart';

class MeterRealtimeCubit extends Cubit<List<AtomatLogResponse>> {
  final SignalRService _signalRService;

  MeterRealtimeCubit(this._signalRService) : super([]);

  Future<void> connect(String meterCode) async {
    await _signalRService.connect(
      meterCode: meterCode,
      onData: (data) {
        try {
          print("📦 Raw realtime data: $data");

          final model = AtomatLogResponse.fromJson(data);

          final updated = List<AtomatLogResponse>.from(state);
          updated.add(model);

          if (updated.length > 50) {
            updated.removeAt(0);
          }

          print("📈 Emit logs length: ${updated.length}");

          emit(updated);
        } catch (e) {
          print("❌ Parse realtime error: $e");
        }
      },
    );
  }

  @override
  Future<void> close() {
    _signalRService.disconnect();
    return super.close();
  }
}