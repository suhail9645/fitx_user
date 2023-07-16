part of 'message_bloc.dart';

abstract class MessageState {}

class MessageInitial extends MessageState {}

class MessageInitialState extends MessageState {
  final WebSocketChannel channel;
  final List<Trainer>allTrainers;

  MessageInitialState({required this.channel,required this.allTrainers});
}

class AllMessagesWithTrainer extends MessageState{
  final List<Message>allMessages;

  AllMessagesWithTrainer({required this.allMessages});
}
