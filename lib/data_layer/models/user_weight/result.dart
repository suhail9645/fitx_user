import 'package:json_annotation/json_annotation.dart';

part 'result.g.dart';

@JsonSerializable()
class Weight {
  String? date;
  double? weight;

  Weight({this.date, this.weight});

  factory Weight.fromJson(Map<String, dynamic> json) {
    return _$WeightFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WeightToJson(this);
}
