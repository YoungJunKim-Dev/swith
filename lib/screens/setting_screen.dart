import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:swith/models/user_model.dart';
import 'package:swith/screens/withdrawal_screen.dart';
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
      Navigator.popUntil(context, ModalRoute.withName("/"));
    }
  }

  void onWithDrawalPressed(context) {
    if (context.mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const WithdrawalScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(title: const Text("Settings")),
        appBar: AppBar(title: const Text("설정")),

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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => onLogOutPressed(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffFF9494),
                        minimumSize: const Size.fromHeight(50), // NEW
                      ),
                      child: const Text(
                        '로그아웃',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () => onWithDrawalPressed(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,

                        minimumSize: const Size.fromHeight(50), // NEW
                      ),
                      child: const Text(
                        '회원탈퇴',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
