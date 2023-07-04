import 'package:flutter/material.dart';

class ChatBottomSheet extends StatefulWidget {
  const ChatBottomSheet({super.key});

  @override
  State<ChatBottomSheet> createState() => _ChatBottomSheetState();
}

class _ChatBottomSheetState extends State<ChatBottomSheet> {
  var _userEnteredMessage = "";
  final _messageController = TextEditingController();

  void onSendPressed() {
    FocusScope.of(context).unfocus();
    _userEnteredMessage = "";
    _messageController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(labelText: "send a message..."),
              onChanged: (value) => {
                setState(() {
                  _userEnteredMessage = value;
                })
              },
            ),
          ),
          IconButton(
            onPressed:
                _userEnteredMessage.trim().isEmpty ? null : onSendPressed,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
