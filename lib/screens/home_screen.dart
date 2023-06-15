import 'package:flutter/material.dart';
import 'package:swith/widgets/home_list_item_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<HomeListItem> roomList = [
    const HomeListItem(title: "공부하자", nickname: "홍길동", roomType: 0)
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var roomItem in roomList)
          GestureDetector(
            onTap: () => print("clicked $num"),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: roomItem,
            ),
          )
      ],
    );
  }
}
