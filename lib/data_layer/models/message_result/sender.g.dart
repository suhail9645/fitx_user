// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sender.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sender _$SenderFromJson(Map<String, dynamic> json) => Sender(
      id: json['id'] as int?,
      name: json['name'] as String?,
      profilePicture: json['profile_picture'],
      username: json['username'] as String?,
      dateOfBirth: json['date_of_birth'],
      email: json['email'] as String?,
      gender: json['gender'],
      isTrainer: json['is_trainer'] as bool?,
    );

Map<String, dynamic> _$SenderToJson(Sender instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profile_picture': instance.profilePicture,
      'username': instance.username,
      'date_of_birth': instance.dateOfBirth,
      'email': instance.email,
      'gender': instance.gender,
      'is_trainer': instance.isTrainer,
    };
