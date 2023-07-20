import 'package:flutter/material.dart';
import 'package:swith/models/room_model.dart';
import 'package:swith/models/user_model.dart';
import 'package:swith/services/signaling_service.dart';
import 'package:swith/widgets/chat/chat_widget.dart';

class ChatBottomSheet extends StatefulWidget {
  final SignallingService signallingService;
  final RoomModel room;
  final UserModel user;

  const ChatBottomSheet(
      {super.key,
      required this.signallingService,
      required this.room,
      required this.user});

  @override
  State<ChatBottomSheet> createState() => _ChatBottomSheetState();
}

class _ChatBottomSheetState extends State<ChatBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Chat(
          signallingService: widget.signallingService,
          room: widget.room,
          user: widget.user,
        ));
  }
}
