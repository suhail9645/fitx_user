import 'package:json_annotation/json_annotation.dart';

import 'receiver.dart';
import 'sender.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  int? id;
  String? text;
  String? type;
  dynamic media;
  Sender? sender;
  Receiver? receiver;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;

  Message({
    this.id,
    this.text,
    this.type,
    this.media,
    this.sender,
    this.receiver,
    this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return _$MessageFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
