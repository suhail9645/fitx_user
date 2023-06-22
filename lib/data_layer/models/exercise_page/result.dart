import 'package:json_annotation/json_annotation.dart';

part 'result.g.dart';

@JsonSerializable()
class Exercise {
  int? id;
  String? name;
  String? description;
  String? demo;
  int? count;
  dynamic duration;
  @JsonKey(name: 'burn_calorie')
  int? burnCalorie;
  @JsonKey(name: 'video_link')
  String? videoLink;
  @JsonKey(name: 'focused_area')
  String? focusedArea;

  Exercise({
    this.id,
    this.name,
    this.description,
    this.demo,
    this.count,
    this.duration,
    this.burnCalorie,
    this.videoLink,
    this.focusedArea,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return _$ExerciseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ExerciseToJson(this);
}
