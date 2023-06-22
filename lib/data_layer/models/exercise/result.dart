import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'result.g.dart';

@JsonSerializable()
class Result extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final String? demo;
  final int? count;
  final dynamic duration;
  @JsonKey(name: 'burn_calorie')
  final int? burnCalorie;
  @JsonKey(name: 'video_link')
  final String? videoLink;
  @JsonKey(name: 'focused_area')
  final String? focusedArea;

  const Result({
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

  factory Result.fromJson(Map<String, dynamic> json) {
    return _$ResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      name,
      description,
      demo,
      count,
      duration,
      burnCalorie,
      videoLink,
      focusedArea,
    ];
  }
}
