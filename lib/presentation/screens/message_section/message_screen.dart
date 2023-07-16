import 'dart:convert';

import 'package:fitx_user/data_layer/models/message_result/message.dart';
import 'package:fitx_user/data_layer/models/trainer/trainer.dart';
import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../logic/message_bloc/message_bloc.dart';
import '../../constants/sized_box.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen(
      {super.key, required this.trainer, required this.channel});
  final Trainer trainer;
  final WebSocketChannel channel;

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  void dispose() {
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    BlocProvider.of<MessageBloc>(context)
        .add(FetchAllMessagesByTrainer(userId: widget.trainer.user!.id!));
    TextEditingController controller = TextEditingController();
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.height;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            widget.trainer.user!.username!,
            style: const TextStyle(color: Colors.black),
          ),
          actions: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget
                      .trainer.user!.profilePicture ??
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
            return SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  StreamBuilder(
                      stream: widget.channel.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          Message message = Message.fromJson(
                              jsonDecode(snapshot.data)['message']);
                          allMessages.add(message);
                        }
                        return Expanded(
                            child: ListView.builder(
                                itemCount: allMessages.length,
                                itemBuilder: (context, index) {
                                  String date=allMessages[index].createdAt!.toString().split('T').last;
                                  return Row(
                                    mainAxisAlignment:
                                        allMessages[index].sender!.id ==
                                                widget.trainer.user!.id
                                            ? MainAxisAlignment.start
                                            : MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 6),
                                        padding: const EdgeInsets.fromLTRB(
                                            12, 12, 3, 3),
                                        decoration: BoxDecoration(
                                          color:
                                              allMessages[index].sender!.id ==
                                                      widget.trainer.user!.id
                                                  ? const Color.fromARGB(
                                                      255, 213, 89, 155)
                                                  : Colors.amber,
                                          borderRadius: BorderRadius.only(
                                            topLeft: const Radius.circular(7),
                                            topRight: const Radius.circular(8),
                                            bottomRight:
                                                allMessages[index].sender!.id ==
                                                        widget.trainer.user!.id
                                                    ? const Radius.circular(12)
                                                    : Radius.zero,
                                            bottomLeft:
                                                allMessages[index].sender!.id !=
                                                        widget.trainer.user!.id
                                                    ? const Radius.circular(12)
                                                    : Radius.zero,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              allMessages[index].text!,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                             Text(
                                              date,
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }));
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
                          InkWell(
                              onTap: () {}, child: const Icon(Icons.file_open)),
                          spaceforwidth10,
                          InkWell(onTap: () {}, child: const Icon(Icons.image)),
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
                              widget.channel.sink.add(jsonEncode({
                                "type": "message",
                                "message": {
                                  "type": "text",
                                  "text": controller.text,
                                  "receiver_id": widget.trainer.user!.id!
                                }
                              }));
                              // await MessageOperationsImp().sendTextMessage(
                              //     trainer.user!.id!,
                              //     controller.text,
                              //     state.channel);
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
