import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:swith/models/user_model.dart';
import 'package:swith/screens/login/login_screen.dart';
import 'package:swith/widgets/profile_widget.dart';

class SettingScreen extends StatefulWidget {
  final UserModel user;
  const SettingScreen({super.key, required this.user});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
  }

  void onLogOutPressed(context) {
    storage.delete(key: "jwt");

    if (context.mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LoginScreen(
            storage: storage,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Settings")),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Profile(
                userName: widget.user.userName,
                userEmail: widget.user.userEmail,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(),
                        onPressed: () => onLogOutPressed(context),
                        child: const Text("Log Out")),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
