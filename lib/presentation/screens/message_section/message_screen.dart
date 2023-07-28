import 'dart:convert';
import 'package:fitx_user/data_layer/models/message_result/message.dart';
import 'package:fitx_user/data_layer/models/user/user.dart';
import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:fitx_user/presentation/screens/message_section/widget/message_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../logic/message_bloc/message_bloc.dart';
import '../../constants/sized_box.dart';
import '../premium_section/premium_screen.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen(
      {super.key, required this.userOrTrainer, required this.channel});
  final User userOrTrainer;
  final WebSocketChannel channel;

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MessageBloc>(context)
        .add(FetchAllMessagesByTrainer(userId: widget.userOrTrainer.id!));
    BlocProvider.of<MessageBloc>(context).add(WastEvent());
  }

  void scrollToBottom() {
    final bottomOffset = scrollController.position.maxScrollExtent;
    scrollController.animateTo(
      bottomOffset,
      duration: const Duration(milliseconds: 200),
      curve: Curves.decelerate,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;
    TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            widget.userOrTrainer.username!,
            style: const TextStyle(color: Colors.black),
          ),
          actions: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget
                      .userOrTrainer.profilePicture ??
                  'https://leadership.ng/wp-content/uploads/2023/03/davido.png'),
            ),
            spaceforwidth10
          ]),
      body: BlocBuilder<MessageBloc, MessageState>(
        builder: (context, state) {
          if (state is AllMessagesWithTrainer) {
            List<Message> allMessages = [];
            final reverseList = state.allMessages.reversed;
            allMessages.addAll(reverseList.toList());
            int listIndex = allMessages.length;
            return SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  StreamBuilder(
                      stream: streamController.stream,
                      builder: (context, snapshot) {
                        SchedulerBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          scrollToBottom();
                        });
                        if (snapshot.hasData) {
                          Message message = Message.fromJson(
                              jsonDecode(snapshot.data)['message']);
                          allMessages.add(message);
                        }
                         SchedulerBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          scrollToBottom();
                        });
                        return Expanded(
                            child: Scrollbar(
                          controller: scrollController,
                          child: ListView.builder(
                              controller: scrollController,
                              itemCount: allMessages.length,
                              itemBuilder: (context, index) {
                                return allMessages[index].type == 'text'
                                    ? Row(
                                        mainAxisAlignment:
                                            allMessages[index].sender!.id ==
                                                    widget.userOrTrainer.id
                                                ? MainAxisAlignment.start
                                                : MainAxisAlignment.end,
                                        children: [
                                          MessageTextContainer(
                                              message: allMessages[index],
                                              userOrTrainer:
                                                  widget.userOrTrainer)
                                        ],
                                      )
                                    : allMessages[index].type == 'image'
                                        ? MessageImageContainer(
                                            message: allMessages[index],
                                            userOrTrainer: widget.userOrTrainer,
                                            listIndex: listIndex,
                                            screenHeight: screenHeight,
                                            screenWidth: screenWidth,
                                            index: index,
                                          )
                                        : const SizedBox();
                              }),
                        ));
                      }),
                  Container(
                    height: 60,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 70, 71, 68),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(19),
                        bottomRight: Radius.circular(19),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          spaceforwidth10,
                          InkWell(
                              onTap: () {
                                BlocProvider.of<MessageBloc>(context).add(
                                    ImageMessageEvent(
                                        channel: widget.channel,
                                        id: widget.userOrTrainer.id!,
                                        source: ImageSource.gallery));
                              },
                              child: const Icon(Icons.image)),
                          spaceforwidth10,
                          InkWell(
                              onTap: () {
                                BlocProvider.of<MessageBloc>(context).add(
                                    ImageMessageEvent(
                                        channel: widget.channel,
                                        id: widget.userOrTrainer.id!,
                                        source: ImageSource.camera));
                              },
                              child: const Icon(Icons.camera)),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: controller,
                                decoration: const InputDecoration(
                                  hintText: 'Message',
                                  floatingLabelStyle:
                                      TextStyle(color: whiteColor),
                                  hintStyle: TextStyle(color: Colors.black),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              child: InkWell(
                            child: const Icon(Icons.send_sharp),
                            onTap: () async {
                              if (controller.text.isNotEmpty) {
                                BlocProvider.of<MessageBloc>(context).add(
                                    TextMessageEvent(
                                        channel: widget.channel,
                                        text: controller.text,
                                        id: widget.userOrTrainer.id!));
                                controller.clear();
                              }
                            },
                          ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
