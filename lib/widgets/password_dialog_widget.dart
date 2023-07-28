import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swith/models/room_model.dart';
import 'package:swith/models/user_model.dart';
import 'package:swith/screens/room/chat_room_screen.dart';
import 'package:swith/screens/room/video_room_screen.dart';
import 'package:swith/services/signaling_service.dart';

class PasswordDialog extends StatefulWidget {
  final SignallingService signallingService;
  final RoomModel room;
  final UserModel user;
  const PasswordDialog(
      {super.key,
      required this.signallingService,
      required this.room,
      required this.user});

  @override
  State<PasswordDialog> createState() => _PasswordDialogState();
}

class _PasswordDialogState extends State<PasswordDialog> {
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _visibility = false;
  String password = "";

  @override
  void initState() {
    _passwordController.addListener(
      () {
        final String text = _passwordController.text;
        _passwordController.value = _passwordController.value.copyWith(
          text: text,
          selection:
              TextSelection(baseOffset: text.length, extentOffset: text.length),
          composing: TextRange.empty,
        );
        password = _passwordController.value.text;
      },
    );
    widget.signallingService.socket?.on("join_private_room", (data) {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) {
            return widget.room.chatType == 0
                ? ChatRoomScreen(
                    room: widget.room,
                    signallingService: widget.signallingService,
                    user: widget.user)
                : VideoRoomScreen(
                    room: widget.room,
                    signallingService: widget.signallingService,
                    user: widget.user);
          }),
        );
      }
    });
    widget.signallingService.socket?.on("wrong_password", (data) {
      _visibility = true;
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  String? passwordValidator(value) {
    String password = value.trim();
    if (password.isEmpty) {
      return 'Enter PW';
    }
    if (password.length < 6) {
      return "6digits";
    }
    return null;
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.signallingService.socket?.emit("join_private_room", {
        "roomId": widget.room.roomId,
        "username": widget.user.userName,
        "password": password
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Enter Room Password"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 80,
              child: Focus(
                onFocusChange: (hasFocus) {
                  _visibility = false;
                  setState(() {});
                },
                child: TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: _passwordController,
                  validator: passwordValidator,
                  maxLength: 6,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    counterText: "",
                    hintText: 'Password',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Visibility(
                  visible: _visibility,
                  child: const Text(
                    "Wrong Password",
                    style: TextStyle(color: Colors.redAccent),
                  )),
            ),
            TextButton(onPressed: onSubmit, child: const Text("Submit")),
          ],
        ),
      ),
    );
  }
}
