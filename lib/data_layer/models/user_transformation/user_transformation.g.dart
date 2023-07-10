// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_transformation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTransformation _$UserTransformationFromJson(Map<String, dynamic> json) =>
    UserTransformation(
      count: json['count'] as int?,
      next: json['next'],
      previous: json['previous'],
      results: json['results'] as List<dynamic>?,
    );

Map<String, dynamic> _$UserTransformationToJson(UserTransformation instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
