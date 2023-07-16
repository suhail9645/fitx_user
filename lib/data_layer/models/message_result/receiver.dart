import 'package:json_annotation/json_annotation.dart';

part 'receiver.g.dart';

@JsonSerializable()
class Receiver {
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

  Receiver({
    this.id,
    this.name,
    this.profilePicture,
    this.username,
    this.dateOfBirth,
    this.email,
    this.gender,
    this.isTrainer,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) {
    return _$ReceiverFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReceiverToJson(this);
}
