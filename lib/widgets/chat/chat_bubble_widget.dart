import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swith/models/message_model.dart';

class ChatBubble extends StatelessWidget {
  final MessageModel message;
  final Map<String, bool> detail;

  const ChatBubble({
    super.key,
    required this.message,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (detail["showTimestamp"] == true)
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                DateFormat('h:mm a').format(message.timestamp),
              ),
            ),
          ),
        if (detail["isMyMessage"] != true)
          if (detail["showUserId"] == true)
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 4),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  message.sender,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 10),
                ),
              ),
            ),
        if (message.sender == "_welcome" || message.sender == "_leave")
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                message.content,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
        if (message.sender != "_welcome" && message.sender != "_leave")
          Align(
            alignment: detail["isMyMessage"] == true
                ? Alignment.topRight
                : Alignment.topLeft,
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.6),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                shape: BoxShape.rectangle,
                //you can change opacity with color here(I used black) for rect
                color: detail["isMyMessage"] == true
                    // ? Colors.white.withOpacity(0.1)
                    // ? const Color(0xff218aff)
                    ? const Color(0xffFF9494)
                    : const Color(0xffd8d8d8),

                //I added some shadow, but you can remove boxShadow also.
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 5.0,
                    offset: Offset(5.0, 5.0),
                  ),
                ],
              ),
              child: Text(
                message.content,
                softWrap: true,
                style: TextStyle(
                    color: detail["isMyMessage"] == true
                        ?
                        // ? Colors.white.withOpacity(0.1)
                        Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
      ],
    );
  }
}
