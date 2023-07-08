// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weight _$WeightFromJson(Map<String, dynamic> json) => Weight(
      date: json['date'] as String?,
      weight: (json['weight'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WeightToJson(Weight instance) => <String, dynamic>{
      'date': instance.date,
      'weight': instance.weight,
    };
