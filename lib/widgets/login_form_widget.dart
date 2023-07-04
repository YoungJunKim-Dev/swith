import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:swith/services/api_service.dart';
import 'package:swith/widgets/bottom_navigaton_bar_widget.dart';

class LoginForm extends StatefulWidget {
  final FlutterSecureStorage storage;
  const LoginForm({super.key, required this.storage});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String emailInput = "";
  String passwordInput = "";
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() {
      final String text = _emailController.text;
      _emailController.value = _emailController.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
      print(_emailController.value.text);
    });
    _passwordController.addListener(() {
      final String text = _passwordController.text;
      _passwordController.value = _passwordController.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
      print(_passwordController.value.text);
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

  void onSignInPressed() {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('LogIn Success')),
      );
      // postSignIn
      // if status code 200 & getJWT
      // saveJWT
      widget.storage.write(key: 'jwt', value: "this_is_jwt");

      if (context.mounted) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const MyBottomNavigationBar()));
      } // else
      // error message
    }
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
          const Text("Your email address"),
          const SizedBox(
            height: 6,
          ),
          TextFormField(
            controller: _emailController,
            validator: emailValidator,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                  onPressed: () => {_emailController.text = ""},
                  icon: const Icon(Icons.cancel)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("Your password"),
          const SizedBox(
            height: 6,
          ),
          TextFormField(
            controller: _passwordController,
            validator: passwordValidator,
            obscureText: _isObscured,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: onSignInPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  child: const Text('Sign In'),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () => {ApiService.postLogIn()},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
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
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 34)),
                      child: const Text('손흥민'),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          {_emailController.text = "hgd@gmail.com"},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
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
