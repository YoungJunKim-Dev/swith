import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:swith/widgets/login_form_widget.dart';

class LoginScreen extends StatefulWidget {
  final FlutterSecureStorage storage;
  const LoginScreen({super.key, required this.storage});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var logger = Logger();
  bool isVerified = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: LoginForm(
                  storage: widget.storage,
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
