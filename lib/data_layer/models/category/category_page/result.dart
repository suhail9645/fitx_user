import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../exercise/exercise.dart';

part 'result.g.dart';

@JsonSerializable()
class Category extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final String? image;
  final String? music;
  @JsonKey(name: 'exercises_count')
  final int? exercisesCount;
  final List<Exercise>exercises=[];
   Category({
    this.id,
    this.name,
    this.description,
    this.image,
    this.music,
    this.exercisesCount,
  });

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
