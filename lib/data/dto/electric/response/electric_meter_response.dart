import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solar_energy/data/dto/lasted_log_data/response/lasted_log_data_response.dart';
import '../../meter/response/meter_response.dart';


part 'electric_meter_response.freezed.dart';
part 'electric_meter_response.g.dart';

@freezed
class ElectricMeter with _$ElectricMeter {
  const factory ElectricMeter({
    @Default(MeterResponse()) MeterResponse meter,
    @Default(LastedLogDataResponse()) LastedLogDataResponse lastedLogData, // Thêm field mới
  }) = _ElectricMeter;

  factory ElectricMeter.fromJson(Map<String, dynamic> json) =>
      _$ElectricMeterFromJson(json);
}
