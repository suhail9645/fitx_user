import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:fitx_user/data_layer/data_provider/access_key/get_new_access_key.dart';
import 'package:fitx_user/data_layer/data_provider/message/message_sending.dart';
import 'package:fitx_user/data_layer/models/message_result/message.dart';
import 'package:fitx_user/data_layer/models/trainer/trainer.dart';
import 'package:fitx_user/data_layer/repositories/message_repo/message_operation_repo.dart';
import 'package:fitx_user/data_layer/repositories/trainer_repo/get_all_trainers.dart';
import 'package:fitx_user/data_layer/repositories/user_report_repo/get_messaged_users.dart';
import 'package:fitx_user/presentation/constants/strings.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../data_layer/models/user/user.dart';
import '../../presentation/screens/premium_section/premium_screen.dart';
part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(MessageInitial()) {
    on<MessageInitialEvent>(messageInitialEvent);
    on<FetchAllMessagesByTrainer>(fetchAllMessagesByTrainer);
    on<WastEvent>(
      (event, emit) => emit(WastState()),
    );
    on<TextMessageEvent>(textMessageEvent);
    on<ImageMessageEvent>(imageMessageEvent);
  }

  Future<void> messageInitialEvent(
      MessageInitialEvent event, Emitter<MessageState> emit) async {
    SharedPreferences shrd = await SharedPreferences.getInstance();
    String access = shrd.getString('accessKey')!;
    late WebSocketChannel channel;
    final newAccess = await GetNewAccessKey.getNewAccessKey();
    if (newAccess.isRight) {
      access = newAccess.right;
      channel = WebSocketChannel.connect(
          Uri.parse('ws://$ip/ws/messages/?token=$access'));
      streamController.addStream(channel.stream);
    }

    final errorOrList = await GetAllTrainersRepo().getAllTrainer();
    final errorOrUserList =
        await GetAllMessagedUsersRepo().getAllMessagedUsers();
    if (errorOrList.isRight && errorOrUserList.isRight) {
      emit(MessageInitialState(
          channel: channel,
          allTrainers: errorOrList.right,
          allUsers: errorOrUserList.right));
    }
  }

  Future<void> fetchAllMessagesByTrainer(
      FetchAllMessagesByTrainer event, Emitter<MessageState> emit) async {
    final errorOrList =
        await MessageOperationRepo().getAllMessages(event.userId);
    if (errorOrList.isRight) {
      emit(AllMessagesWithTrainer(allMessages: errorOrList.right));
    }
  }

  Future<void> textMessageEvent(
      TextMessageEvent event, Emitter<MessageState> emit) async {
    await MessageSending().sendTextMessage(event.id, event.text, event.channel);
  }

  Future<void> imageMessageEvent(
      ImageMessageEvent event, Emitter<MessageState> emit) async {
    final image = await ImagePicker().pickImage(source: event.source);
    if (image != null) {
      emit(ImageMessageLoadingState());
      await MessageSending()
          .sendImagesAndFiles(event.id, File(image.path), event.channel);
    }
  }
}
