import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:swith/models/user_model.dart';
import 'package:swith/screens/login/signup_scren.dart';
import 'package:swith/screens/room_list_screen.dart';
import 'package:swith/services/api_service.dart';

class LoginForm extends StatefulWidget {
  final FlutterSecureStorage storage;
  const LoginForm({super.key, required this.storage});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var logger = Logger();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late UserModel user;

  String emailInput = "";
  String passwordInput = "";
  bool _isObscured = true;
  //error 문구 visibility 변수
  bool _visibility = false;

  @override
  void initState() {
    super.initState();

    //textfield controllers
    _emailController.addListener(() {
      final String text = _emailController.text;
      _emailController.value = _emailController.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
      logger.d(_emailController.value.text);
    });
    _passwordController.addListener(() {
      final String text = _passwordController.text;
      _passwordController.value = _passwordController.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
      logger.d(_passwordController.value.text);
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //validator for email
  String? emailValidator(value) {
    RegExp emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    String email = value.trim();

    if (!emailValid.hasMatch(email)) {
      return 'Please enter your right email';
    }
    return null;
  }

  //validator for password
  String? passwordValidator(value) {
    RegExp passwordValid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
    String password = value.trim();

    if (!passwordValid.hasMatch(password)) {
      return 'Please enter your right password';
    }
    return null;
  }

  void onLogInPressed() async {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.

      http.Response response = await ApiService.postLogIn(
          _emailController.text, _passwordController.text);

      if (response.statusCode == 200) {
        logger.d(response.body);
        var result = jsonDecode(response.body);
        user = UserModel.fromJson({
          "userId": result["user_id"],
          "userName": result["user_name"],
          "userEmail": _emailController.text
        });

        // saveJWT
        await widget.storage.write(key: 'jwt', value: result["token"]);
        await widget.storage.write(key: 'user_info', value: jsonEncode(user));

        //show login success snackbar & navigate to roomlistscreen
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('LogIn Success')),
          );
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => RoomListScreen(
                    user: user,
                  )));
        } // else
      } else {
        _visibility = true;
        setState(() {});
      }
    }
  }

  void onSignUpPressed() {
    if (context.mounted) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const SignupScreen()));
    } //
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              "Swith",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          const Center(child: Text("Study with us")),
          const SizedBox(
            height: 20,
          ),
          const Text("Login with Your Account"),
          const SizedBox(
            height: 14,
          ),
          Focus(
            onFocusChange: (hasFocus) {
              _visibility = false;
              setState(() {});
            },
            child: TextFormField(
              controller: _emailController,
              validator: emailValidator,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "Email",
                suffixIcon: IconButton(
                    onPressed: () => {_emailController.text = ""},
                    icon: const Icon(Icons.cancel)),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Focus(
            onFocusChange: (hasFocus) {
              _visibility = false;
              setState(() {});
            },
            child: TextFormField(
              controller: _passwordController,
              validator: passwordValidator,
              obscureText: _isObscured,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                labelText: "Password",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                    onPressed: () => {
                          setState(() {
                            _isObscured = !_isObscured;
                          })
                        },
                    icon: _isObscured
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off)),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Visibility(
                visible: _visibility,
                child: const Text(
                  "You entered Wrong Email or Password",
                  style: TextStyle(color: Colors.redAccent),
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: onLogInPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  child: const Text('Log In'),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: onSignUpPressed,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  child: const Text('Sign Up'),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => {
                        _emailController.text = "son7@gmail.com",
                        _passwordController.text = "1Q2w3e4r!"
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 34)),
                      child: const Text('손흥민'),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () => {
                        _emailController.text = "hgd@gmail.com",
                        _passwordController.text = "1Q2w3e4r!"
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 34) // NEW
                          ),
                      child: const Text('홍길동'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
