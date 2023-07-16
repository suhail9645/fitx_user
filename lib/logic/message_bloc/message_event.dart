part of 'message_bloc.dart';

abstract class MessageEvent {}

class MessageInitialEvent extends MessageEvent {
 
}

class FetchAllMessagesByTrainer extends MessageEvent {
  final int userId;

  FetchAllMessagesByTrainer({required this.userId});
}

class TextMessageEvent extends MessageEvent {
  final WebSocketChannel channel;
  final String text;

  TextMessageEvent({required this.channel, required this.text});
}

class ImageMessageEvent extends MessageEvent {
  final WebSocketChannel channel;

  ImageMessageEvent({
    required this.channel,
  });
}

class FileMessageEvent extends MessageEvent {
  final WebSocketChannel channel;

  FileMessageEvent({required this.channel});
}
