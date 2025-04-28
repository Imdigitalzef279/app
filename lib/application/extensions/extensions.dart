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

extension EnergyFormatExtension on double {
  String get toKWhFormatted {
    if (this >= 1e12) {
      return '${(this / 1e12).toStringAsFixed(1)} TWh';
    } else if (this >= 1e9) {
      return '${(this / 1e9).toStringAsFixed(1)} GWh';
    } else if (this >= 1e6) {
      return '${(this / 1e6).toStringAsFixed(1)} MWh';
    } else if (this >= 1e3) {
      return '${(this / 1e3).toStringAsFixed(1)} kWh';
    } else {
      return '${toStringAsFixed(1)} Wh';
    }
  }
}

