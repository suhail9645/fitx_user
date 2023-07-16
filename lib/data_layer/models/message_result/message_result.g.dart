// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageResult _$MessageResultFromJson(Map<String, dynamic> json) =>
    MessageResult(
      type: json['type'] as String?,
      message: json['message'] == null
          ? null
          : Message.fromJson(json['message'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageResultToJson(MessageResult instance) =>
    <String, dynamic>{
      'type': instance.type,
      'message': instance.message,
    };
