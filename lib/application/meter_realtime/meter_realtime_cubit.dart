import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/signalr_service.dart';
import '../../data/dto/atomat/atomat_log_response.dart';

class MeterRealtimeCubit extends Cubit<List<AtomatLogResponse>> {
  final SignalRService _signalRService;

  MeterRealtimeCubit(this._signalRService) : super([]);

  Future<void> connect(String meterCode) async {
    await _signalRService.connect(
      meterCode: meterCode,
    );

    _signalRService.stream.listen((data) {
      try {
        final dto = data["breakerMeterDataDto"];
        if (dto == null) return;

        final raw = Map<String, dynamic>.from(dto);

        raw.updateAll((key, value) {
          if (value is String) {
            final numValue = num.tryParse(value);
            return numValue ?? value;
          }
          return value;
        });

        raw["updatedAt"] = data["updatedAt"];

        final log = AtomatLogResponse.fromJson(raw);

        final updated = List<AtomatLogResponse>.from(state);
        updated.insert(0, log);

        if (updated.length > 30) {
          updated.removeLast();
        }

        emit(updated);

      } catch (e) {
        print("❌ Parse realtime error: $e");
      }
    });
  }

  @override
  Future<void> close() {
    _signalRService.disconnect();
    return super.close();
  }
}