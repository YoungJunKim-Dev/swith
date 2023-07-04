import 'package:flutter/material.dart';
import 'package:swith/screens/room_list_screen.dart';
import 'package:swith/screens/setting_screen.dart';
import 'package:swith/screens/test_screen.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;

  List<Widget> screenOptions = <Widget>[
    const RoomListScreen(),
    const SettingScreen(),
    const TestScreen()
  ];

  void onNavigationTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.amber,
        onTap: onNavigationTapped,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.meeting_room), label: "Rooms"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "settings"),
          BottomNavigationBarItem(
              icon: Icon(Icons.temple_buddhist), label: "test"),
        ],
        currentIndex: _selectedIndex,
      ),
    );
  }
}
