import 'package:json_annotation/json_annotation.dart';

part 'sender.g.dart';

@JsonSerializable()
class Sender {
  int? id;
  String? name;
  @JsonKey(name: 'profile_picture')
  dynamic profilePicture;
  String? username;
  @JsonKey(name: 'date_of_birth')
  dynamic dateOfBirth;
  String? email;
  dynamic gender;
  @JsonKey(name: 'is_trainer')
  bool? isTrainer;

  Sender({
    this.id,
    this.name,
    this.profilePicture,
    this.username,
    this.dateOfBirth,
    this.email,
    this.gender,
    this.isTrainer,
  });

  factory Sender.fromJson(Map<String, dynamic> json) {
    return _$SenderFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SenderToJson(this);
}
