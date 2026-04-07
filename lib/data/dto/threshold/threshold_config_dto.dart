class ThresholdConfigDto {
  final String code;
  final String value;

  ThresholdConfigDto({
    required this.code,
    required this.value,
  });

  factory ThresholdConfigDto.fromJson(Map<String, dynamic> json) {
    return ThresholdConfigDto(
      code: json['queryCode'] ?? '',
      value: json['queryValue'] ?? '0',
    );
  }
}