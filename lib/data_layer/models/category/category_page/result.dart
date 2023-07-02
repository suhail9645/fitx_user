// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:fitx_user/data_layer/models/exercise_page/result.dart';
import 'package:json_annotation/json_annotation.dart';

part 'result.g.dart';

@JsonSerializable()
class Category extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final String? image;
  final String? music;
  final int? likes;
   bool isLiked=false;
  @JsonKey(name: 'exercises_count')
  final int? exercisesCount;
  final List<Exercise> exercises = [];
  Category(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.music,
      this.exercisesCount,
      this.likes});

  factory Category.fromJson(Map<String, dynamic> json) {
    return _$CategoryFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      name,
      description,
      image,
      music,
      exercisesCount,
    ];
  }
}
