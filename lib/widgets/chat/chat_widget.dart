import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:swith/models/message_model.dart';
import 'package:swith/models/room_model.dart';
import 'package:swith/models/user_model.dart';
import 'package:swith/services/signaling_service.dart';
import 'package:swith/widgets/chat/chat_bubble_widget.dart';

class Chat extends StatefulWidget {
  final SignallingService signallingService;
  final RoomModel room;
  final UserModel user;

  const Chat(
      {super.key,
      required this.signallingService,
      required this.room,
      required this.user});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  var logger = Logger();

  late SignallingService signallingService;
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  var chats = [];

  @override
  void initState() {
    signallingService = widget.signallingService;
    signallingService.socket?.on("message", (message) {
      logger.d('received message : $message');
    });
    signallingService.socket?.on("welcome", (content) {
      var message = MessageModel(
          sender: "_welcome",
          roomId: widget.room.roomId,
          timestamp: DateTime.now(),
          content: content);
      chats.add(message);
      logger.d(content);
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  void onSendPressed() {
    FocusScope.of(context).unfocus();
    String content = _messageController.text.trim();

    if (content != '') {
      var message = MessageModel(
          sender: widget.user.userName,
          roomId: widget.room.roomId,
          timestamp: DateTime.now(),
          content: content);
      var jsonMessage = message.toJson();
      logger.d(jsonMessage);

      signallingService.socket?.emit("message", {"message": jsonMessage});
      chats.add(message);
    }
    _messageController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          padding: const EdgeInsets.only(top: 16, left: 16, bottom: 20),
          itemCount: chats.length,
          itemBuilder: (__, index) {
            var detail = {
              "isMyMessage": false,
              "showUserId": true,
              "showTimestamp": true
            };
            var currentMessage = chats[index];
            if (currentMessage.sender == widget.user.userName) {
              detail["isMyMessage"] = true;
            }
            if (index == 0) {
            } else {
              var formerMessage = chats[index - 1];
              if (formerMessage.sender == currentMessage.sender) {
                detail["showUserId"] = false;
              }
              if (DateFormat('h:mm a').format(formerMessage.timestamp) ==
                  DateFormat('h:mm a').format(currentMessage.timestamp)) {
                detail["showTimestamp"] = false;
              }
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ChatBubble(message: chats[index], detail: detail),
            );
          },
        )),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration:
                    const InputDecoration(labelText: "send a message..."),
              ),
            ),
            IconButton(
              onPressed: onSendPressed,
              icon: const Icon(Icons.send),
            ),
          ],
        ),
      ],
    );
  }
}
