import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:swith/models/room_model.dart';
import 'package:swith/models/user_model.dart';
import 'package:swith/screens/room/chat_room_screen.dart';
import 'package:swith/screens/room/video_room_screen.dart';
import 'package:swith/screens/setting_screen.dart';
import 'package:swith/services/signaling_service.dart';
import 'package:swith/widgets/filter/filter_dialog_widget.dart';
import 'package:swith/widgets/password_dialog_widget.dart';
import 'package:swith/widgets/room_list_item_widget.dart';
import 'package:swith/widgets/new_room_bottom_sheet_widget.dart';

typedef FilterOptions = Map<String, List<bool>>;

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

  //방 목록 필터 옵션
  FilterOptions filterOptions = {
    "broadcastType": [true, false],
    "studyType": [true, true, true, true],
    "chatType": [true, false],
    "isPublic": [true, true],
  };

  List<RoomListItem> roomList = [];

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
    addSocket();
  }

  void addSocket() {
    signallingService.socket?.on("success_join_room", (data) {
      var map = {
        "roomId": data["roomId"],
        "creator": data["attributes"]['creator'],
        "password": data["attributes"]['password'],
        "broadcastType": data["attributes"]['broadcastType'],
        "studyType": data["attributes"]['studyType'],
        "isPublic": data["attributes"]['isPublic'],
        "chatType": data["attributes"]['chatType'],
      };

      RoomModel room = RoomModel.fromJson(map);

      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return room.chatType == 0
                ? ChatRoomScreen(
                    room: room,
                    signallingService: signallingService,
                    user: widget.user)
                : VideoRoomScreen(
                    room: room,
                    signallingService: signallingService,
                    user: widget.user);
          }),
        );
      }
    });
    signallingService.socket?.on("fail_join_room", (data) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data)),
        );
      }
      getRoomLists();
    });
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
          "password": attributes['password'],
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
    if (roomItem.room.isPublic == 0) {
      signallingService.socket?.emit("join_room",
          {"roomId": roomItem.room.roomId, "username": widget.user.userName});
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return PasswordDialog(
            signallingService: signallingService,
            room: roomItem.room,
            user: widget.user,
          );
        },
      );
    }
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

  void onFilterPressed(context) {
    showDialog(
      context: context,
      builder: (context) {
        return FilterDialog(
          filterOptions: filterOptions,
        );
      },
    ).then((value) {
      filterOptions = value ?? filterOptions;
      getRoomLists();
    });
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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(child: Text("방 목록")),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => onNewRoomPressed(context),
          label: const Text('방 만들기'),
          icon: const Icon(Icons.chat),
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 25, left: 25, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  roomList.isNotEmpty &&
                          ((defaultTargetPlatform == TargetPlatform.iOS) ||
                              (defaultTargetPlatform == TargetPlatform.android))
                      ? const SizedBox.shrink()
                      : IconButton(
                          onPressed: () async {
                            getRoomLists();
                          },
                          icon: const Icon(Icons.refresh)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // const Text("인기순"),
                      // const SizedBox(
                      //   width: 6,
                      // ),
                      // const Text("최신순"),
                      // const SizedBox(
                      //   width: 6,
                      // ),
                      IconButton(
                        onPressed: () {
                          onFilterPressed(context);
                        },
                        icon: const Icon(Icons.tune),
                      ),
                      IconButton(
                        onPressed: () {
                          onSettingsPressed(context);
                        },
                        icon: const Icon(Icons.settings),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    getRoomLists();
                  },
                  child: roomList.isEmpty
                      ? const Center(
                          child: Text("방이 없습니다!"),
                        )
                      : ListView(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          controller: _scrollController,
                          children: [
                            for (var roomItem in roomList)
                              filterOptions["studyType"]![
                                              roomItem.room.studyType] ==
                                          true &&
                                      filterOptions["isPublic"]![
                                              roomItem.room.isPublic] ==
                                          true
                                  ? GestureDetector(
                                      onTap: () =>
                                          onRoomItemTapped(context, roomItem),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: roomItem,
                                      ),
                                    )
                                  : const SizedBox.shrink()
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
