import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final int? id;
  final String? name;
  @JsonKey(name: 'profile_picture')
  final String? profilePicture;
  final String? username;
  @JsonKey(name: 'date_of_birth')
  final String? dateOfBirth;
  final String? email;
  final dynamic gender;

  const User({
    this.id,
    this.name,
    this.profilePicture,
    this.username,
    this.dateOfBirth,
    this.email,
    this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    int? id,
    String? name,
    String? profilePicture,
    String? username,
    String? dateOfBirth,
    String? email,
    dynamic gender,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      profilePicture: profilePicture ?? this.profilePicture,
      username: username ?? this.username,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      email: email ?? this.email,
      gender: gender ?? this.gender,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      profilePicture,
      username,
      dateOfBirth,
      email,
      gender,
    ];
  }
}
