import 'package:solar_energy/application/enums/index_type.dart';

extension IndexExtension on IndexType {
  String get title {
    switch (this) {
      case IndexType.normal:
        return 'Ngắt kêt nối';
      case IndexType.good:
        return 'Bình thường';
      case IndexType.high:
        return 'Cao';
      case IndexType.very_hight:
        return 'Quá cao';
      default:
        return '';
    }
  }
}
