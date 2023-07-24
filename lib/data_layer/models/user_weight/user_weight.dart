import 'package:json_annotation/json_annotation.dart';

part 'user_weight.g.dart';

@JsonSerializable()
class UserWeight {
  int? count;
  dynamic next;
  dynamic previous;
  List<dynamic>? results;

  UserWeight({this.count, this.next, this.previous, this.results});

  factory UserWeight.fromJson(Map<String, dynamic> json) {
    return _$UserWeightFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserWeightToJson(this);
}
