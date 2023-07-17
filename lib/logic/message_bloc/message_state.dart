part of 'message_bloc.dart';

abstract class MessageState {}

class MessageInitial extends MessageState {}

class MessageInitialState extends MessageState {
  final WebSocketChannel channel;
  final List<Trainer>allTrainers;
  final List<User>allUsers;
  MessageInitialState({required this.channel,required this.allTrainers,required this.allUsers});
}

class AllMessagesWithTrainer extends MessageState{
  final List<Message>allMessages;

  AllMessagesWithTrainer({required this.allMessages});
}
class WastState extends MessageState{}
