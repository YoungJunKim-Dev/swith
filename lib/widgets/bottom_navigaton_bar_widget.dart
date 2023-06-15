import 'package:flutter/material.dart';
import 'package:swith/screens/favorite_screen.dart';
import 'package:swith/screens/home_screen.dart';
import 'package:swith/screens/setting_screen.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;

  List<Widget> screenOptions = <Widget>[
    HomeScreen(),
    const FavoriteScreen(),
    const SettingScreen()
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
        onTap: onNavigationTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "favorite"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "settings"),
        ],
        currentIndex: _selectedIndex,
      ),
    );
  }
}
