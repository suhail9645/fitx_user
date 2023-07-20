// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      music: json['music'] as String?,
      exercisesCount: json['exercises_count'] as int?,
      likes: json['likes'] as int?,
    )..isLiked = json['isLiked'] as bool;

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'music': instance.music,
      'likes': instance.likes,
      'isLiked': instance.isLiked,
      'exercises_count': instance.exercisesCount,
    };
