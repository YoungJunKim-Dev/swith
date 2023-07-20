import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:swith/models/room_model.dart';
import 'package:swith/models/user_model.dart';
import 'package:swith/screens/room/chat_room_screen.dart';
import 'package:swith/screens/room/video_room_screen.dart';
import 'package:swith/services/signaling_service.dart';
import 'package:swith/widgets/room_types_toggle_button_widget.dart';

class NewRoomBottomSheet extends StatefulWidget {
  final UserModel user;
  final SignallingService signallingService;

  const NewRoomBottomSheet(
      {super.key, required this.signallingService, required this.user});

  @override
  State<NewRoomBottomSheet> createState() => _NewRoomBottomSheetState();
}

class _NewRoomBottomSheetState extends State<NewRoomBottomSheet> {
  String roomId = "";
  String creator = "";
  int broadcastType = 0;
  int studyType = 0;
  int isPublic = 0;
  int chatType = 0;
  bool alreadyExist = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _roomIdController = TextEditingController();
  late SignallingService signallingService;
  var logger = Logger();

  @override
  void initState() {
    //roomId text 컨트롤러 addListener
    _roomIdController.addListener(
      () {
        final String text = _roomIdController.text;
        _roomIdController.value = _roomIdController.value.copyWith(
          text: text,
          selection:
              TextSelection(baseOffset: text.length, extentOffset: text.length),
          composing: TextRange.empty,
        );
        roomId = _roomIdController.value.text;
      },
    );

    signallingService = widget.signallingService;

    //방 만들기 성공
    signallingService.socket?.on(
      "create_room_succeded",
      (data) {
        logger.d("create room Succeeded?");
        data.remove("count");
        logger.d("data : $data");
        //bottom sheet close
        // Navigator.of(context).pop();
        //print("Pop succedd");
        //room screen으로 이동

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) {
              return chatType == 0
                  ? ChatRoomScreen(
                      room: RoomModel.fromJson(data),
                      signallingService: signallingService,
                      user: widget.user,
                    )
                  : VideoRoomScreen(
                      room: RoomModel.fromJson(data),
                      user: widget.user,
                      signallingService: widget.signallingService,
                    );
            }),
          );
        }
      },
    );
    //방이 이미 존재할 때
    signallingService.socket?.on(
      "already_exist",
      (data) {
        logger.d("already exist");
        alreadyExist = true;
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _roomIdController.dispose();

    super.dispose();
  }

  String? roomIdValidator(value) {
    String roomId = value.trim();
    logger.d(roomId.isEmpty);
    if (roomId.isEmpty) {
      return 'Please enter room name';
    } else if (alreadyExist) {
      return "Already exist";
    }
    return null;
  }

  //create room button 이벤트
  void onCreateRoomPressed(context) {
    alreadyExist = false;
    //room model 생성
    // final room = RoomModel.fromJson({
    //   "roomId": roomId,
    //   "creator": creator,
    //   "broadcastType": broadcastType,
    //   "studyType": studyType,
    //   "isPublic": isPublic
    // });

    //room 생성
    if (_formKey.currentState!.validate()) {
      signallingService.socket?.emit("create_room", {
        "roomId": roomId,
        "creator": widget.user.userName,
        "broadcastType": broadcastType,
        "studyType": studyType,
        "isPublic": isPublic,
        "chatType": chatType
      });
    }
  }

  //bt 버튼 클릭 이벤트
  void setChatType(int ct) {
    chatType = ct;
  }

  //bt 버튼 클릭 이벤트
  void setBroadcastType(int bt) {
    broadcastType = bt;
  }

  //st 버튼 클릭 이벤트
  void setStudyType(int st) {
    studyType = st;
  }

  //ip 버튼 클릭 이벤트
  void setIsPublic(int ip) {
    isPublic = ip;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, right: 20, left: 20),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Create Room",
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    controller: _roomIdController,
                    validator: roomIdValidator,
                    decoration: InputDecoration(
                      hintText: 'Enter room name',
                      suffixIcon: IconButton(
                        onPressed: _roomIdController.clear,
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                RoomTypesToggleButton(
                    typeName: "chatType",
                    options: const [
                      Text("Message"),
                      Text("Video"),
                    ],
                    notifier: (idx) => setChatType(idx)),
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
                  height: 30,
                ),
                TextButton(
                  onPressed: () => onCreateRoomPressed(context),
                  style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      backgroundColor:
                          Theme.of(context).colorScheme.onPrimaryContainer),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Create Room",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
