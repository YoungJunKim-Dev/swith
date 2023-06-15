import 'package:flutter/material.dart';

class HomeListItem extends StatelessWidget {
  final String title;
  final String nickname;
  final int roomType;

  const HomeListItem(
      {super.key,
      required this.title,
      required this.nickname,
      required this.roomType});

  static const roomTypeOption = ['공개방', '비공개방'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 26),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                nickname,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.blueAccent),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                roomTypeOption[roomType],
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.green),
              )
            ],
          )
        ],
      ),
    );
  }
}
