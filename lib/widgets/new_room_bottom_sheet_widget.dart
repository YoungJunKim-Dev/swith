import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
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
  String password = "none";
  int broadcastType = 0;
  int studyType = 0;
  int isPublic = 0;
  int chatType = 0;
  bool alreadyExist = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _roomIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  late SignallingService signallingService;
  var logger = Logger();

  @override
  void initState() {
    //roomId text 컨트롤러 addListener
    _roomIdController.addListener(
      () {
        roomId = _roomIdController.text;
      },
    );
    _passwordController.addListener(
      () {
        password = _passwordController.text;
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

        if (mounted) {
          alreadyExist = true;
          setState(() {});
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
    _passwordController.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  String? roomIdValidator(value) {
    String roomId = value.trim();
    logger.d(roomId.isEmpty);
    if (roomId.isEmpty) {
      return 'Please enter room name';
    }
    return null;
  }

  String? passwordValidator(value) {
    String password = value.trim();
    logger.d(roomId.isEmpty);
    if (password.isEmpty) {
      return 'Enter PW';
    }
    if (password.length < 6) {
      return "6digits";
    }
    return null;
  }

  //create room button 이벤트
  void onCreateRoomPressed(context) {
    alreadyExist = false;

    //room 생성
    if (_formKey.currentState!.validate()) {
      signallingService.socket?.emit("create_room", {
        "roomId": roomId,
        "creator": widget.user.userName,
        "password": password,
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
    if (ip == 0) password = "none";
    setState(() {});
    SchedulerBinding.instance.addPostFrameCallback((_) => scrollToEnd());
  }

  void scrollToEnd() async {
    await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut);
    // Scrollable.ensureVisible(lastKey.currentContext);
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
                  "새로운 방 만들기",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Focus(
                    onFocusChange: (hasFocus) {
                      alreadyExist = false;
                      setState(() {});
                    },
                    child: TextFormField(
                      controller: _roomIdController,
                      validator: roomIdValidator,
                      maxLength: 12,
                      decoration: InputDecoration(
                        hintText: '방 이름을 입력하세요',
                        suffixIcon: IconButton(
                          onPressed: _roomIdController.clear,
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Visibility(
                    visible: alreadyExist,
                    child: const Text(
                      "같은 이름이 이미 존재합니다",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        RoomTypesToggleButton(
                          typeName: "chatType",
                          options: const [
                            Text("메세지"),
                            Text("화상"),
                          ],
                          notifier: (idx) => setChatType(idx),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        RoomTypesToggleButton(
                          typeName: "broadcastType",
                          options: const [
                            Icon(Icons.people),
                            Icon(Icons.groups)
                          ],
                          notifier: (idx) => setBroadcastType(idx),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        RoomTypesToggleButton(
                          typeName: "studyType",
                          options: const [
                            Text("수능"),
                            Text("공무원"),
                            Text("취준"),
                            Text("개발"),
                          ],
                          notifier: (idx) => setStudyType(idx),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        RoomTypesToggleButton(
                          typeName: "isPublic",
                          options: const [
                            Text("공개"),
                            Text("비공개"),
                          ],
                          notifier: (idx) => setIsPublic(idx),
                        ),
                        isPublic == 0
                            ? const SizedBox.shrink()
                            : Column(
                                children: [
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  SizedBox(
                                    width: 80,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      controller: _passwordController,
                                      validator: passwordValidator,
                                      maxLength: 6,
                                      decoration: const InputDecoration(
                                        hintText: '비밀번호',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
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
                      "생성",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
