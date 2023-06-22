// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      demo: json['demo'] as String?,
      count: json['count'] as int?,
      duration: json['duration'],
      burnCalorie: json['burn_calorie'] as int?,
      videoLink: json['video_link'] as String?,
      focusedArea: json['focused_area'] as String?,
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'demo': instance.demo,
      'count': instance.count,
      'duration': instance.duration,
      'burn_calorie': instance.burnCalorie,
      'video_link': instance.videoLink,
      'focused_area': instance.focusedArea,
    };
