import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:swith/models/room_model.dart';
import 'package:swith/models/user_model.dart';
import 'package:swith/screens/room/chat_room_screen.dart';
import 'package:swith/screens/room/video_room_screen.dart';
import 'package:swith/screens/setting_screen.dart';
import 'package:swith/services/signaling_service.dart';
import 'package:swith/widgets/room_list_item_widget.dart';
import 'package:swith/widgets/new_room_bottom_sheet_widget.dart';

class RoomListScreen extends StatefulWidget {
  final UserModel user;
  const RoomListScreen({super.key, required this.user});
  @override
  State<RoomListScreen> createState() => _RoomListScreenState();
}

class _RoomListScreenState extends State<RoomListScreen> {
  var logger = Logger();
  late SignallingService signallingService;
  final ScrollController _scrollController = ScrollController();

  var testTitle = "test";

  //방 목록 필터 옵션
  final filterOptions = {
    "broadcastType": "1:1",
    "studyType": "development",
    "isPublic": true,
    "isFull": true
  };

  final List<RoomModel> roomLists = [];

  List<RoomListItem> roomList = [
    // RoomListItem(
    //   room: RoomModel.fromJson(
    //     {
    //       "roomId": "공부하자",
    //       "creator": "hgd",
    //       "broadcastType": 0,
    //       "studyType": 0,
    //       "isPublic": 0,
    //       "chatType": 1,
    //     },
    //   ),
    // ),
    // RoomListItem(
    //   room: RoomModel.fromJson(
    //     {
    //       "roomId": "공부하자",
    //       "creator": "hgd",
    //       "broadcastType": 0,
    //       "studyType": 0,
    //       "isPublic": 0,
    //       "chatType": 1,
    //     },
    //   ),
    // ),
    // RoomListItem(
    //   room: RoomModel.fromJson(
    //     {
    //       "roomId": "공부하자",
    //       "creator": "hgd",
    //       "broadcastType": 0,
    //       "studyType": 0,
    //       "isPublic": 0,
    //       "chatType": 1,
    //     },
    //   ),
    // ),
  ];

  @override
  void initState() {
    signallingService = SignallingService();
    init();
    logger.d("user : ${widget.user}");
    logger.d("room list scereen init");
    super.initState();
  }

  @override
  void dispose() {
    // signallingService.socket?.disconnect();
    logger.d("room list screen disposed");
    super.dispose();
  }

  void init() {
    signallingService.connectSocket();

    //room list 가져오기
    signallingService.socket?.on("get_room_lists", (data) {
      updateRoomList(data);
    });
    getRoomLists();
  }

  void getRoomLists() {
    signallingService.socket?.emit("get_room_lists");
  }

  //room list 가져와서 listview에 추가하기
  void updateRoomList(data) {
    roomList.clear();
    data.forEach(
      (roomId, attributes) {
        var map = {
          "roomId": roomId,
          "creator": attributes['creator'],
          "broadcastType": attributes['broadcastType'],
          "studyType": attributes['studyType'],
          "isPublic": attributes['isPublic'],
          "chatType": attributes['chatType'],
        };
        roomList.add(
          RoomListItem(
            room: RoomModel.fromJson(map),
          ),
        );
      },
    );

    if (mounted) {
      // logger.d("get_room_lists called and mounted");
      setState(() {});
    }
  }

  void onRoomItemTapped(context, roomItem) {
    signallingService.socket?.emit("join_room",
        {"roomId": roomItem.room.roomId, "username": widget.user.userName});

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return roomItem.room.chatType == 0
            ? ChatRoomScreen(
                room: roomItem.room,
                signallingService: signallingService,
                user: widget.user)
            : VideoRoomScreen(
                room: roomItem.room,
                signallingService: signallingService,
                user: widget.user);
      }),
    );
  }

  void onSettingsPressed(context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return SettingScreen(
          user: widget.user,
        );
      },
    ));
  }

  void onNewRoomPressed(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      context: context,
      builder: (context) {
        return NewRoomBottomSheet(
          signallingService: signallingService,
          user: widget.user,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => onNewRoomPressed(context),
          label: const Text('New Room'),
          icon: const Icon(Icons.chat),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Rooms",
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                  TextButton.icon(
                      onPressed: () {
                        onSettingsPressed(context);
                      },
                      icon: const Icon(Icons.settings),
                      label: const Text("settings")),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () async {
                        getRoomLists();
                      },
                      icon: const Icon(Icons.refresh)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("인기순"),
                      const SizedBox(
                        width: 6,
                      ),
                      const Text("최신순"),
                      const SizedBox(
                        width: 6,
                      ),
                      IconButton(
                          onPressed: () => {}, icon: const Icon(Icons.tune)),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    getRoomLists();
                  },
                  child: ListView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    controller: _scrollController,
                    children: [
                      for (var roomItem in roomList)
                        GestureDetector(
                          onTap: () => onRoomItemTapped(context, roomItem),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: roomItem,
                          ),
                        )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  color: Colors.transparent,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
