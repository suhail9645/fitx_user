import 'package:json_annotation/json_annotation.dart';

part 'result.g.dart';

@JsonSerializable()
class TImage {
  int? id;
  String? image;
  String? date;

  TImage({this.id, this.image, this.date});

  factory TImage.fromJson(Map<String, dynamic> json) {
    return _$TImageFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TImageToJson(this);
}
