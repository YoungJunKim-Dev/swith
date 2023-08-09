import 'package:flutter/material.dart';
import 'package:swith/models/room_model.dart';
import 'package:swith/models/user_model.dart';
import 'package:swith/services/signaling_service.dart';
import 'package:swith/widgets/chat/chat_bottom_sheet_widget.dart';
//import webrtc & socketIO package

class VideoRoomScreen extends StatefulWidget {
  final UserModel user;
  final RoomModel room;
  final SignallingService signallingService;
  const VideoRoomScreen(
      {super.key,
      required this.room,
      required this.signallingService,
      required this.user});

  @override
  State<VideoRoomScreen> createState() => _VideoRoomScreenState();
}

class _VideoRoomScreenState extends State<VideoRoomScreen> {
  //final _localRenderer = RTCVideoRenderer();
  //final _remoteRenderer = RTCVideoRenderer();
  // MediaStream? _localStream;
  // RTCPeerConnection? myPeerConnection;
  late SignallingService signallingService;
  final List chatHistory = [];

  bool videoTurnedOn = true;
  bool audioTurnedOn = true;
  final myUsername = "nano";

  @override
  void initState() {
    // _localRenderer.initialize();
    // _remoteRenderer.initialize();
    signallingService = widget.signallingService;
    super.initState();
  }

  @override
  void dispose() {
    // _localRenderer.dispose();
    // _remoteRenderer.dispose();
    // signallingService.socket?.disconnect();
    signallingService.socket?.emit(
        "leave_room", {"myUsername": myUsername, "roomId": widget.room.roomId});
    super.dispose();
  }

  //비디오 온오프
  void videoTurnOnOff() {
    videoTurnedOn = !videoTurnedOn;

    setState(() {});
  }

  //audio 온오프
  void audioTurnOnOff() {
    audioTurnedOn = !audioTurnedOn;
    signallingService.socket?.emit("test", "test");
    setState(() {});
  }

  void onClosePressed() {
    Navigator.of(context).pop();
  }

  //chat창 확대
  void onShowChatsPressed(context) {
    showModalBottomSheet(
      showDragHandle: true,
      // isScrollControlled: true,

      context: context,
      builder: (context) {
        return ChatBottomSheet(
          signallingService: signallingService,
          room: widget.room,
          user: widget.user,
        );
      },
    );
  }

  // Future make

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.room.roomId),
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 25, left: 25, right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  // child: RTCVideoView(
                  //   _localRenderer,
                  //   mirror: true,
                  // ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  // child: RTCVideoView(_remoteRenderer),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () => {audioTurnOnOff()},
                      child: Icon(audioTurnedOn ? Icons.mic : Icons.mic_off)),
                  ElevatedButton(
                      onPressed: () => {videoTurnOnOff()},
                      child: Icon(videoTurnedOn
                          ? Icons.video_camera_front
                          : Icons.videocam_off)),
                  ElevatedButton(
                    onPressed: onClosePressed,
                    child: const Icon(Icons.phone_disabled),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      color: Theme.of(context).colorScheme.onSecondary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      child: const Row(
                        children: [
                          Text(
                            "nico : ",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "hello",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () => onShowChatsPressed(context),
                      icon: const Icon(Icons.arrow_upward))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
