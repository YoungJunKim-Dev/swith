import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:swith/widgets/signup_form_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var logger = Logger();
  bool isVerified = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: SignupForm(),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
