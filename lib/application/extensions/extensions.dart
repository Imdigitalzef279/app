import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String formatTime({String pattern = 'dd/MM/yyyy'}) {
    try {
      return DateFormat(pattern).format(this);
    } on Exception catch (e, stackTrace) {
      return '';
    }
  }
}

extension DoubleExtension on double {
  String get toKWorMW {
    switch (this) {
      case double value when value >= 1e9:
        return '${(value / 1e9).toStringAsFixed(1)} TW';
      case double value when value >= 1e6:
        return '${(value / 1e6).toStringAsFixed(1)} GW';
      case double value when value >= 1e3:
        return '${(value / 1e3).toStringAsFixed(1)} MW';
      case double value when value >= 1:
        return '${(value).toStringAsFixed(1)} kW';
      default:
        return '${toStringAsFixed(1)} kW';
    }
  }
}
