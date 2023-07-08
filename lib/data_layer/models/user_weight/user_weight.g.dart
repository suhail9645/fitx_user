// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_weight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWeight _$UserWeightFromJson(Map<String, dynamic> json) => UserWeight(
      count: json['count'] as int?,
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Weight.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserWeightToJson(UserWeight instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
