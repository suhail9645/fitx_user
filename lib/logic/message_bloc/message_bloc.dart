import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitx_user/data_layer/models/message_result/message.dart';
import 'package:fitx_user/data_layer/models/trainer/trainer.dart';
import 'package:fitx_user/data_layer/repositories/message_repo/message_operation_repo.dart';
import 'package:fitx_user/data_layer/repositories/trainer_repo/get_all_trainers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(MessageInitial()) {
   on<MessageInitialEvent>(messageInitialEvent);
   on<FetchAllMessagesByTrainer>(fetchAllMessagesByTrainer);
  }

  Future<void> messageInitialEvent(MessageInitialEvent event, Emitter<MessageState> emit)async {
    SharedPreferences shrd=await SharedPreferences.getInstance();
    String access=shrd.getString('accessKey')!;
    WebSocketChannel channel = WebSocketChannel.connect(Uri.parse('ws://192.168.43.130:8000/ws/messages/?token=$access'));
    final errorOrList=await GetAllTrainersRepo().getAllTrainer();
    if(errorOrList.isRight){
      emit(MessageInitialState(channel: channel, allTrainers: errorOrList.right));
    }
  }
  
  Future<void> fetchAllMessagesByTrainer(FetchAllMessagesByTrainer event, Emitter<MessageState> emit)async {
   final errorOrList=await  MessageOperationRepo().getAllMessages(event.userId);
   if(errorOrList.isRight){
      emit(AllMessagesWithTrainer(allMessages: errorOrList.right));
    }
  }
  }

