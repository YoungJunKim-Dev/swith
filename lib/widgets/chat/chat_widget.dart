import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  var chats = [];

  @override
  void initState() {
    signallingService = widget.signallingService;
    signallingService.socket?.on("message", (message) {
      chats.add(MessageModel.fromJson(message));

      if (mounted) {
        setState(() {});
      }
      SchedulerBinding.instance.addPostFrameCallback((_) => scrollToEnd());
    });
    signallingService.socket?.on("welcome", (content) {
      var message = MessageModel(
          userId: 0,
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
    signallingService.socket?.on("leave_room", (content) {
      var message = MessageModel(
          userId: 0,
          sender: "_leave",
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

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void onSendPressed() {
    FocusScope.of(context).unfocus();
    String content = _messageController.text.trim();

    if (content != '') {
      var message = MessageModel(
          userId: widget.user.userId,
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
    SchedulerBinding.instance.addPostFrameCallback((_) => scrollToEnd());
  }

  void scrollToEnd() async {
    if (_scrollController.hasClients) {
      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    }
    // Scrollable.ensureVisible(lastKey.currentContext);
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
          // padding: const EdgeInsets.only(top: 16, left: 16, bottom: 20),
          itemCount: chats.length,
          itemBuilder: (__, index) {
            // if (index == chats.length) {
            //   return const SizedBox(
            //     height: 30,
            //   );
            // }
            var detail = {
              "isMyMessage": false,
              "showUserId": true,
              "showTimestamp": true
            };
            var currentMessage = chats[index];
            if (currentMessage.userId == widget.user.userId) {
              detail["isMyMessage"] = true;
            }
            if (index == 0) {
            } else {
              var formerMessage = chats[index - 1];
              //현재 메시지와 이전 메시지의 sender가 동일하면 표시 안함
              if (formerMessage.userId == currentMessage.userId) {
                detail["showUserId"] = false;
              }
              //현재 메시지와 이전 메시지의 timestamp가 동일하면 표시 안함
              if (DateFormat('h:mm a').format(formerMessage.timestamp) ==
                  DateFormat('h:mm a').format(currentMessage.timestamp)) {
                detail["showTimestamp"] = false;
              }
            }
            //welcome or leave 메세지일 경우 detail 설정
            if (currentMessage.sender == "_welcome" ||
                currentMessage.sender == "_leave") {
              detail["showUserId"] = false;
              detail["showTimestamp"] = false;
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
                decoration: const InputDecoration(labelText: "메세지 보내기..."),
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
