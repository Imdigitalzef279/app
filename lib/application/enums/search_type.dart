import 'package:freezed_annotation/freezed_annotation.dart';

enum SearchType {
  @JsonValue('HOUR')
  hour,
  @JsonValue('MONTH')
  month,
  @JsonValue('YEAR')
  year
}
