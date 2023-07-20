import 'package:flutter/material.dart';
import 'package:swith/models/room_model.dart';
import 'package:swith/models/user_model.dart';
import 'package:swith/services/signaling_service.dart';
import 'package:swith/widgets/chat/chat_widget.dart';
//import webrtc & socketIO package

class ChatRoomScreen extends StatefulWidget {
  final UserModel user;
  final RoomModel room;
  final SignallingService signallingService;
  const ChatRoomScreen(
      {super.key,
      required this.room,
      required this.signallingService,
      required this.user});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  late SignallingService signallingService;
  final List chatHistory = [];

  bool videoTurnedOn = true;
  bool audioTurnedOn = true;

  @override
  void initState() {
    signallingService = widget.signallingService;
    signallingService.socket?.on("welcome", (data) => print(data));
    // init();
    super.initState();
  }

  @override
  void dispose() {
    // signallingService.socket?.disconnect();
    signallingService.socket?.emit("leave_room",
        {"myUsername": widget.user.userName, "roomId": widget.room.roomId});
    super.dispose();
  }

  void init() {
    // signallingService.connectSocket();
  }

  //비디오 온오프

  void onClosePressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Chat Room : ${widget.room.roomId}",
                    style: const TextStyle(fontSize: 30),
                  ),
                ],
              ),
              Expanded(
                  child: Chat(
                signallingService: signallingService,
                room: widget.room,
                user: widget.user,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
