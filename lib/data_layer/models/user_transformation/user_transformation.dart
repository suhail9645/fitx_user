import 'package:json_annotation/json_annotation.dart';


part 'user_transformation.g.dart';

@JsonSerializable()
class UserTransformation {
  int? count;
  dynamic next;
  dynamic previous;
  List<dynamic>? results;

  UserTransformation({this.count, this.next, this.previous, this.results});

  factory UserTransformation.fromJson(Map<String, dynamic> json) {
    return _$UserTransformationFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserTransformationToJson(this);
}
