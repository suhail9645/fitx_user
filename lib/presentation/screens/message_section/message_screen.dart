import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitx_user/data_layer/models/user/user.dart';
import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../data_layer/models/message_result/message.dart';
import '../../../logic/message_bloc/message_bloc.dart';
import '../../constants/sized_box.dart';


class MessageScreen extends StatefulWidget {
  const MessageScreen(
      {super.key, required this.userOrTrainer, required this.channel});
  final User userOrTrainer;
  final WebSocketChannel channel;
  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  void initState() {
    BlocProvider.of<MessageBloc>(context).add(WastEvent());
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int listIndex=0;
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;
    BlocProvider.of<MessageBloc>(context)
        .add(FetchAllMessagesByTrainer(userId: widget.userOrTrainer.id!));
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
        buildWhen: (previous, current) => current is !LoadingState&& current is !LoadedState,
        builder: (context, state) {
          if (state is AllMessagesWithTrainer) {
            List<Message> allMessages = [];
            final reverseList = state.allMessages.reversed;
            allMessages.addAll(reverseList.toList());
            listIndex=allMessages.length;
            return SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  children: [
                    allMessages.isNotEmpty
                        ? StreamBuilder(
                            stream: streamController.stream,
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
                                        DateTime dateTime = allMessages[index]
                                            .createdAt!
                                            .toLocal();

                                        return allMessages[index].type == 'text'
                                            ? Row(
                                                mainAxisAlignment: allMessages[
                                                                index]
                                                            .sender!
                                                            .id ==
                                                        widget.userOrTrainer.id
                                                    ? MainAxisAlignment.start
                                                    : MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 12,
                                                        vertical: 6),
                                                    padding: const EdgeInsets
                                                        .fromLTRB(12, 12, 3, 3),
                                                    decoration: BoxDecoration(
                                                      color: allMessages[index]
                                                                  .sender!
                                                                  .id ==
                                                              widget
                                                                  .userOrTrainer
                                                                  .id
                                                          ? const Color
                                                                  .fromARGB(
                                                              255, 213, 89, 155)
                                                          : Colors.amber,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft: const Radius
                                                            .circular(7),
                                                        topRight: const Radius
                                                            .circular(8),
                                                        bottomRight: allMessages[
                                                                        index]
                                                                    .sender!
                                                                    .id ==
                                                                widget
                                                                    .userOrTrainer
                                                                    .id
                                                            ? const Radius
                                                                .circular(12)
                                                            : Radius.zero,
                                                        bottomLeft: allMessages[
                                                                        index]
                                                                    .sender!
                                                                    .id !=
                                                                widget
                                                                    .userOrTrainer
                                                                    .id
                                                            ? const Radius
                                                                .circular(12)
                                                            : Radius.zero,
                                                      ),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(
                                                          allMessages[index]
                                                              .text!,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                        Text(
                                                          '${dateTime.hour}:${dateTime.minute}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : allMessages[index].type == 'image'
                                                ? Row(
                                                    mainAxisAlignment:
                                                        allMessages[index]
                                                                    .sender!
                                                                    .id ==
                                                                widget
                                                                    .userOrTrainer
                                                                    .id
                                                            ? MainAxisAlignment
                                                                .start
                                                            : MainAxisAlignment
                                                                .end,
                                                    children: [
                                                      CachedNetworkImage(
                                                        imageUrl: index<listIndex?
                                                            allMessages[index]
                                                                .media:'http://10.4.4.26:8000${allMessages[index].media}',
                                                        imageBuilder: (context,
                                                                imageProvider) =>
                                                            Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      12,
                                                                  vertical: 6),
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  12, 12, 3, 3),
                                                          height: screenHeight *
                                                              0.30,
                                                          width: screenWidth *
                                                              0.70,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: const Radius
                                                                  .circular(16),
                                                              topRight: const Radius
                                                                  .circular(16),
                                                              bottomRight: allMessages[
                                                                              index]
                                                                          .sender!
                                                                          .id ==
                                                                      widget
                                                                          .userOrTrainer
                                                                          .id
                                                                  ? const Radius
                                                                      .circular(16)
                                                                  : Radius.zero,
                                                              bottomLeft: allMessages[
                                                                              index]
                                                                          .sender!
                                                                          .id !=
                                                                      widget
                                                                          .userOrTrainer
                                                                          .id
                                                                  ? const Radius
                                                                      .circular(16)
                                                                  : Radius.zero,
                                                            ),
                                                            image: DecorationImage(
                                                                image:
                                                                    imageProvider,
                                                                fit: BoxFit
                                                                    .fill),
                                                          ),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            child: Text(
                                                              '${dateTime.hour}:${dateTime.minute}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ),
                                                        placeholder: (context,
                                                                url) =>
                                                            const CircularProgressIndicator(),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      12,
                                                                  vertical: 6),
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  12, 12, 3, 3),
                                                          height: screenHeight *
                                                              0.30,
                                                          width: screenWidth *
                                                              0.70,
                                                          decoration: BoxDecoration(
                                                            
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color:
                                                                  Colors.red),
                                                          child: const Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                'Something wrong',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                              Icon(Icons.error)
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                : const SizedBox();
                                      }));
                            })
                        : const Expanded(
                            child: Center(child: Text('No Messages Yet')),
                          ),
                     BlocBuilder<MessageBloc, MessageState>(builder: (context, state) {
                       if(state is LoadingState){
                        return const SizedBox(height: 50,width: 50,child: Center(child: CircularProgressIndicator(),),);
                       }else{
                        return const SizedBox();
                       }
                     },),
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
                                          id: widget.userOrTrainer.id!,source: ImageSource.gallery));
                                },
                                child: const Icon(Icons.image)),spaceforwidth10,
                                InkWell(
                                onTap: () {
                                  BlocProvider.of<MessageBloc>(context).add(
                                      ImageMessageEvent(
                                          channel: widget.channel,
                                          id: widget.userOrTrainer.id!,source: ImageSource.camera));
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
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                child: InkWell(
                              child: const Icon(Icons.send_sharp),
                              onTap: () async {
                                BlocProvider.of<MessageBloc>(context).add(
                                    TextMessageEvent(
                                        channel: widget.channel,
                                        text: controller.text,
                                        id: widget.userOrTrainer.id!));
                              },
                            ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ));
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
