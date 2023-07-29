

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../data_layer/models/message_result/message.dart';
import '../../../../data_layer/models/user/user.dart';

class MessageImageContainer extends StatelessWidget {
  const MessageImageContainer({
    super.key,
    required this.message,
    required this.userOrTrainer,
    required this.listIndex,
    required this.screenHeight,
    required this.screenWidth,
    required this.index,
  });
  final double screenHeight;
  final double screenWidth;
  final Message message;
  final User userOrTrainer;
  final int listIndex;
  final int index;
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = message.createdAt!.toLocal();
    
    return Row(
      mainAxisAlignment: message.sender!.id == userOrTrainer.id
          ? MainAxisAlignment.start
          : MainAxisAlignment.end,
      children: [
        CachedNetworkImage(
          imageUrl: index < listIndex
              ? message.media
              : 'http://10.4.4.26:8000${message.media}',
          imageBuilder: (context, imageProvider) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            padding: const EdgeInsets.fromLTRB(12, 12, 3, 3),
            height: screenHeight * 0.30,
            width: screenWidth * 0.70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomRight: message.sender!.id == userOrTrainer.id
                    ? const Radius.circular(16)
                    : Radius.zero,
                bottomLeft: message.sender!.id != userOrTrainer.id
                    ? const Radius.circular(16)
                    : Radius.zero,
              ),
              image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                '${dateTime.hour}:${dateTime.minute}',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[500]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
                 margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            padding: const EdgeInsets.fromLTRB(12, 12, 3, 3),
              height: screenHeight * 0.30,
              width: screenWidth * 0.70,
                color: Colors.black.withOpacity(0.3),
            ),
          ),
        )
      ],
    );
  }
}

class MessageTextContainer extends StatefulWidget {
  const MessageTextContainer(
      {super.key, required this.message, required this.userOrTrainer});

  final Message message;
  final User userOrTrainer;

  @override
  State<MessageTextContainer> createState() => _MessageTextContainerState();
}

class _MessageTextContainerState extends State<MessageTextContainer> {
  double width = 0.0;
GlobalKey globalKey = GlobalKey();

 @override
  void initState() {
    // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    //   width = globalKey.currentContext!.size!.width;
    //   print('the new height is $width');
    //  setState(() {});
    // });
   
    super.initState();
      
  }
  
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = widget.message.createdAt!.toLocal();
    return Container(
      key: globalKey,
      constraints:const BoxConstraints(maxWidth: 300),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.fromLTRB(12, 12, 3, 3),
      decoration: BoxDecoration(
        color: widget.message.sender!.id == widget.userOrTrainer.id
            ? const Color.fromARGB(255, 213, 89, 155)
            : Colors.amber,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(7),
          topRight: const Radius.circular(8),
          bottomRight: widget.message.sender!.id == widget.userOrTrainer.id
              ? const Radius.circular(12)
              : Radius.zero,
          bottomLeft: widget.message.sender!.id != widget.userOrTrainer.id
              ? const Radius.circular(12)
              : Radius.zero,
        ),
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.end,
       
        children: [
          Text(
            widget.message.text!,overflow: TextOverflow.visible,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
          ),
           Text(
               '${dateTime.hour}:${dateTime.minute}',textAlign: TextAlign.end,
               style: const TextStyle(color: Colors.black),
             ),
        
        ],
      ),
    );
  }
}
