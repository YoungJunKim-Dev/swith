import 'package:flutter/material.dart';
import 'package:swith/models/room_model.dart';
import 'package:swith/screens/room_screen.dart';
import 'package:swith/services/signaling_service.dart';
import 'package:swith/widgets/room_list_item_widget.dart';
import 'package:swith/widgets/new_room_bottom_sheet_widget.dart';

class RoomListScreen extends StatefulWidget {
  const RoomListScreen({super.key});

  @override
  State<RoomListScreen> createState() => _RoomListScreenState();
}

class _RoomListScreenState extends State<RoomListScreen> {
  late SignallingService signallingService;
  var testTitle = "test";

  @override
  void initState() {
    signallingService = SignallingService();
    init();
    super.initState();
  }

  @override
  void dispose() {
    // signallingService.socket?.disconnect();
    super.dispose();
  }

  void init() {
    signallingService.connectSocket();
    signallingService.socket?.on("already_exist", (data) {
      print(data);
    });
    signallingService.socket?.on("get_room_lists", (data) {
      updateRoomList(data);
    });
    getRoomLists();
  }

  void getRoomLists() {
    signallingService.socket?.emit("get_room_lists");
  }

  void updateRoomList(data) {
    data.forEach((roomId, attributes) {
      roomList.add(RoomListItem(
        title: roomId,
        username: "니코",
        broadcastType: 0,
        studyType: 0,
        isPublic: 1,
      ));
    });
    if (mounted) {
      setState(() {});
    }
    print(data);
  }

  final filterOptions = {
    "broadcastType": "1:1",
    "studyType": "development",
    "isPublic": true
  };

  final List<RoomModel> roomLists = [];

  List<RoomListItem> roomList = [
    const RoomListItem(
      title: "공부하자",
      username: "홍길동",
      broadcastType: 0,
      studyType: 0,
      isPublic: 0,
    ),
    const RoomListItem(
      title: "공부하자",
      username: "홍길동",
      broadcastType: 0,
      studyType: 0,
      isPublic: 0,
    ),
    const RoomListItem(
      title: "공부하자",
      username: "홍길동",
      broadcastType: 0,
      studyType: 0,
      isPublic: 0,
    ),
  ];

  void onRoomItemTapped(context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => RoomScreen(
              signallingService: signallingService,
            )));
  }

  void onNewRoomPressed(context) {
    showModalBottomSheet(
      // isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          color: Colors.amber,
          child: Center(
              child: NewRoomBottomSheet(
            signallingService: signallingService,
          )),
        );
      },
    );
  }

  void onTestPressed() {
    signallingService.socket?.emit("create_room", {
      "roomId": "room1",
      "username": "nico",
      "broadcastType": 0,
      "studyType": 0,
      "isPublic": 0
    });

    signallingService.socket?.emit("create_room", {
      "roomId": "room2",
      "username": "cado",
      "broadcastType": 0,
      "studyType": 0,
      "isPublic": 0
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const Text(
                  "Rooms",
                  style: TextStyle(fontSize: 50),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: onTestPressed, icon: const Icon(Icons.telegram))
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("인기순"),
                SizedBox(
                  width: 6,
                ),
                Text("최신순"),
                SizedBox(
                  width: 6,
                ),
                Text("필터")
              ],
            ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: [
                  for (var roomItem in roomList)
                    GestureDetector(
                      onTap: () => onRoomItemTapped(context),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: roomItem,
                      ),
                    )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton.extended(
                      onPressed: () => onNewRoomPressed(context),
                      label: const Text('New Room'),
                      icon: const Icon(Icons.chat),
                      backgroundColor: Colors.pink.shade500,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
