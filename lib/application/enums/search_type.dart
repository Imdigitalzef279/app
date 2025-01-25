import 'package:freezed_annotation/freezed_annotation.dart';

enum SearchType {
  @JsonValue('HOUR')
  hour,
  @JsonValue('DAY')
  day,
  @JsonValue('MONTH')
  month
}
