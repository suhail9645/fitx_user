// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryPage _$CategoryPageFromJson(Map<String, dynamic> json) => CategoryPage(
      count: json['count'] as int?,
      next: json['next'],
      previous: json['previous'],
      results: json['results'] as List<dynamic>?,
    );

Map<String, dynamic> _$CategoryPageToJson(CategoryPage instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
