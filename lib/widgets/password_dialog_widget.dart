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
      widget.signallingService.socket?.emit("join_room",
          {"roomId": widget.room.roomId, "username": widget.user.userName});

      Navigator.of(context).push(
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
            const SizedBox(
              height: 10,
            ),
            TextButton(onPressed: onSubmit, child: const Text("Submit")),
          ],
        ),
      ),
    );
  }
}
