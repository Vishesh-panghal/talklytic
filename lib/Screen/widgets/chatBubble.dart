// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:talklytic/Data/Modal/chatRoomModal.dart';
import 'package:talklytic/firebase/firebaseProvider.dart';

class ChatBubble extends StatefulWidget {
  msgModal message;
  ChatBubble({
    required this.message,
  });

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    var currUser = FirebaseProvider.currUsrId;
    return widget.message.fromId == currUser ? fromMsgWidget() : toMsgWidget();
  }

  Widget fromMsgWidget() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.amber.shade200,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(5))),
      child: Text(widget.message.message),
    );
  }

  Widget toMsgWidget() {
    var sentTime = TimeOfDay.fromDateTime(
      DateTime.fromMillisecondsSinceEpoch(
        int.parse(widget.message.sent),
      ),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.blue.shade200,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(5))),
          child: Text(widget.message.message),
        ),
        Text(sentTime.format(context)),
      ],
    );
  }
}

class $ {}
