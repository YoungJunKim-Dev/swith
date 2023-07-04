import 'package:flutter/material.dart';

class RoomListItem extends StatelessWidget {
  final String title;
  final String username;
  final int broadcastType;
  final int studyType;
  final int isPublic;

  const RoomListItem(
      {super.key,
      required this.title,
      required this.username,
      required this.broadcastType,
      required this.studyType,
      required this.isPublic});

  static const broadcastTypeOptions = ['1:1', '1:N', 'M:N'];
  static const studyTypeOptions = ['수능', '공무원', '취준', '개발'];
  static const isPublicOptions = ['공개방', '비공개방'];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 26),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.blueAccent),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      broadcastTypeOptions[broadcastType],
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.green),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      studyTypeOptions[studyType],
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.green),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      isPublicOptions[isPublic],
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.green),
                    ),
                  ],
                )
              ],
            ),
            ElevatedButton.icon(
                onPressed: () => {},
                icon: const Icon(Icons.meeting_room),
                label: const Text("enter"))
          ],
        ),
      ),
    );
  }
}
