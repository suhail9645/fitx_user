import 'package:json_annotation/json_annotation.dart';

import 'certificate.dart';
import 'user.dart';

part 'trainer.g.dart';

@JsonSerializable()
class Trainer {
  int? id;
  User? user;
  String? phone;
  List<Certificate>? certificates;
  String? experience;

  Trainer({
    this.id,
    this.user,
    this.phone,
    this.certificates,
    this.experience,
  });

  factory Trainer.fromJson(Map<String, dynamic> json) {
    return _$TrainerFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TrainerToJson(this);
}
