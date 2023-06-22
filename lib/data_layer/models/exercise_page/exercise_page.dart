import 'package:json_annotation/json_annotation.dart';

import 'result.dart';

part 'exercise_page.g.dart';

@JsonSerializable()
class ExercisePage {
  int? count;
  dynamic next;
  dynamic previous;
  List<dynamic>? results;

  ExercisePage({this.count, this.next, this.previous, this.results});

  factory ExercisePage.fromJson(Map<String, dynamic> json) {
    return _$ExercisePageFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ExercisePageToJson(this);
}
