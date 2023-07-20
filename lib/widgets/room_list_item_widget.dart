import 'package:flutter/material.dart';
import 'package:swith/models/room_model.dart';
import 'package:swith/widgets/card_widget.dart';

class RoomListItem extends StatelessWidget {
  final RoomModel room;

  const RoomListItem({super.key, required this.room});

  static const chatTypeOptions = ['채팅', '비디오'];
  static const broadcastTypeOptions = ['1:1', '1:N', 'M:N'];
  static const studyTypeOptions = ['수능', '공무원', '취준', '개발'];
  static const isPublicOptions = ['공개방', '비공개방'];

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  room.roomId,
                  style: const TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 26),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      room.creator,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.blueAccent),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      chatTypeOptions[room.chatType],
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.green),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      broadcastTypeOptions[room.broadcastType],
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.green),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      studyTypeOptions[room.studyType],
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.green),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      isPublicOptions[room.isPublic],
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.green),
                    ),
                  ],
                )
              ],
            ),
            IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.meeting_room),
            )
          ],
        ),
      ),
    );
  }
}
