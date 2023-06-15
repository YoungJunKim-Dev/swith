import 'package:flutter/material.dart';
import 'package:swith/widgets/profile_widget.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Profile()
      ],
    );
  }
}
