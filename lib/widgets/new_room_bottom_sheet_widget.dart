import 'package:flutter/material.dart';
import 'package:swith/models/room_model.dart';
import 'package:swith/screens/room_screen.dart';
import 'package:swith/services/signaling_service.dart';
import 'package:swith/widgets/room_types_toggle_button_widget.dart';

class NewRoomBottomSheet extends StatefulWidget {
  final SignallingService signallingService;

  const NewRoomBottomSheet({super.key, required this.signallingService});

  @override
  State<NewRoomBottomSheet> createState() => _NewRoomBottomSheetState();
}

class _NewRoomBottomSheetState extends State<NewRoomBottomSheet> {
  late String roomId;
  late int broadcastType;
  late int studyType;
  late int isPublic;
  final TextEditingController _roomIdController = TextEditingController();

  @override
  void initState() {
    _roomIdController.addListener(() {
      final String text = _roomIdController.text;
      _roomIdController.value = _roomIdController.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );

      roomId = _roomIdController.value.text;
      print(roomId);
    });
    super.initState();
  }

  void onCreateRoomPressed(context) {
    final room = RoomModel.fromJson({
      "roomId": roomId,
      "broadcastType": broadcastType,
      "studyType": studyType,
      "isPublic": isPublic
    });
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RoomScreen(
          room: room,
          signallingService: widget.signallingService,
        ),
      ),
    );
  }

  void setBroadcastType(int bt) {
    broadcastType = bt;
    print(broadcastType);
  }

  void setStudyType(int st) {
    studyType = st;
    print(studyType);
  }

  void setIsPublic(int ip) {
    isPublic = ip;
    print(isPublic);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: _roomIdController,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          RoomTypesToggleButton(
              typeName: "broadcastType",
              options: const [
                Icon(Icons.person),
                Icon(Icons.people),
                Icon(Icons.groups)
              ],
              notifier: (idx) => setBroadcastType(idx)),
          const SizedBox(
            height: 20,
          ),
          RoomTypesToggleButton(
              typeName: "studyType",
              options: const [
                Text("수능"),
                Text("공무원"),
                Text("취준"),
                Text("개발"),
              ],
              notifier: (idx) => setStudyType(idx)),
          const SizedBox(
            height: 20,
          ),
          RoomTypesToggleButton(
              typeName: "isPublic",
              options: const [
                Text("Public"),
                Text("Private"),
              ],
              notifier: (idx) => setIsPublic(idx)),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            child: const Text("Create Room"),
            onPressed: () => onCreateRoomPressed(context),
          ),
        ],
      ),
    );
  }
}
