import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:swith/screens/login_screen.dart';
import 'package:swith/widgets/profile_widget.dart';

class SettingScreen extends StatelessWidget {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  const SettingScreen({super.key});

  void onLogOutPressed(context) {
    storage.delete(key: "jwt");

    if (context.mounted) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        const Profile(),
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () => onLogOutPressed(context),
                  child: const Text("Log Out")),
            ),
          ],
        ),
      ],
    );
  }
}
