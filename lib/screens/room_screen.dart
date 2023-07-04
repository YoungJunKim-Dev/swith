import 'package:flutter/material.dart';
import 'package:swith/models/room_model.dart';
import 'package:swith/services/signaling_service.dart';
import 'package:swith/widgets/chat_bottom_sheet_widget.dart';
//import webrtc & socketIO package

class RoomScreen extends StatefulWidget {
  final RoomModel? room;
  final SignallingService signallingService;
  const RoomScreen({super.key, this.room, required this.signallingService});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  //final _localRenderer = RTCVideoRenderer();
  //final _remoteRenderer = RTCVideoRenderer();
  // MediaStream? _localStream;
  // RTCPeerConnection? myPeerConnection;
  late SignallingService signallingService;

  bool videoTurnedOn = true;
  bool audioTurnedOn = true;

  @override
  void initState() {
    // _localRenderer.initialize();
    // _remoteRenderer.initialize();
    // signallingService = SignallingService();
    signallingService = widget.signallingService;
    // init();
    super.initState();
  }

  @override
  void dispose() {
    // _localRenderer.dispose();
    // _remoteRenderer.dispose();
    // signallingService.socket?.disconnect();
    super.dispose();
  }

  void init() {
    // signallingService.connectSocket();
  }

  void videoTurnOnOff() {
    videoTurnedOn = !videoTurnedOn;

    setState(() {});
  }

  void audioTurnOnOff() {
    audioTurnedOn = !audioTurnedOn;
    signallingService.socket?.emit("test", "test");
    setState(() {});
  }

  void onShowChatsPressed(context) {
    showModalBottomSheet(
      // isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          color: Colors.amber,
          child: const Center(child: ChatBottomSheet()),
        );
      },
    );
  }

  // Future make

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade300,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text("Room"),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              height: 220,
              // child: RTCVideoView(
              //   _localRenderer,
              //   mirror: true,
              // ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              height: 220,
              // child: RTCVideoView(_remoteRenderer),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () => {audioTurnOnOff()},
                    child: Icon(audioTurnedOn ? Icons.mic : Icons.mic_off)),
                ElevatedButton(
                    onPressed: () => {videoTurnOnOff()},
                    child: Icon(videoTurnedOn
                        ? Icons.video_camera_front
                        : Icons.videocam_off)),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => {Navigator.pop(context)},
              child: const Icon(Icons.cancel),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: const Row(
                    children: [
                      Text(
                        "nico",
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
    );
  }
}
