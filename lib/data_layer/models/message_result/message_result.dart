import 'package:json_annotation/json_annotation.dart';

import 'message.dart';

part 'message_result.g.dart';

@JsonSerializable()
class MessageResult {
  String? type;
  Message? message;

  MessageResult({this.type, this.message});

  factory MessageResult.fromJson(Map<String, dynamic> json) {
    return _$MessageResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MessageResultToJson(this);
}
