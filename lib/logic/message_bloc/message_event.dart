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
  final int id;
  TextMessageEvent({required this.channel, required this.text,required this.id});
}

class ImageMessageEvent extends MessageEvent {
  final WebSocketChannel channel;
  final int id;
  ImageMessageEvent({
    required this.channel,required this.id
  });
}

class WastEvent extends MessageEvent{}
