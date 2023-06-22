// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExercisePage _$ExercisePageFromJson(Map<String, dynamic> json) => ExercisePage(
      count: json['count'] as int?,
      next: json['next'],
      previous: json['previous'],
      results: json['results'] as List<dynamic>?,
    );

Map<String, dynamic> _$ExercisePageToJson(ExercisePage instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
