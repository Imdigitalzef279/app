// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_config_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AlarmConfigResponseImpl _$$AlarmConfigResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AlarmConfigResponseImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$$AlarmConfigResponseImplToJson(
        _$AlarmConfigResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
