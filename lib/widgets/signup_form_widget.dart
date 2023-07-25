import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:swith/models/user_model.dart';
import 'package:swith/services/api_service.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({
    super.key,
  });

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  var logger = Logger();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  late UserModel user;

  String emailInput = "";
  String passwordInput = "";
  bool _isObscured = true;
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
    _nameController.addListener(() {
      final String text = _nameController.text;
      _nameController.value = _nameController.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
      logger.d(_nameController.value.text);
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
    _confirmPasswordController.addListener(() {
      final String text = _confirmPasswordController.text;
      _confirmPasswordController.value =
          _confirmPasswordController.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
      logger.d(_confirmPasswordController.value.text);
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

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

  //validator for name
  String? nameValidator(value) {
    RegExp nameValid = RegExp(r"^[가-힣a-zA-Z]{2,15}");
    String name = value.trim();

    if (!nameValid.hasMatch(name)) {
      return 'Please enter right name';
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

  //validator for confirm password
  String? confirmPasswordValidator(value) {
    String confirmPassword = value.trim();

    logger.d(confirmPassword != _passwordController.text);
    if (confirmPassword != _passwordController.text) {
      return 'Passwords doesn\'t match';
    }
    return null;
  }

  void onSignupPressed() async {
    if (_formKey.currentState!.validate()) {
      http.Response response = await ApiService.postSignUp(
          _emailController.text,
          _passwordController.text,
          _nameController.text);
      if (response.statusCode == 200) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('SignUp Success!')),
          );
          Navigator.of(context).pop();
        }
      } else {
        _visibility = true;
        setState(() {});
      }
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
          const Text("Create Your Account"),
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
                labelText: "Email",
                border: const OutlineInputBorder(),
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
              controller: _nameController,
              validator: nameValidator,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: "Name",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                    onPressed: () => {_nameController.text = ""},
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
          TextFormField(
            controller: _confirmPasswordController,
            validator: confirmPasswordValidator,
            obscureText: _isObscured,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              labelText: "Confirm Password",
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
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Visibility(
                visible: _visibility,
                child: const Text(
                  "Email already exist",
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
                  onPressed: onSignupPressed,
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
                        _passwordController.text = "1Q2w3e4r!",
                        _confirmPasswordController.text = "1Q2w3e4r!"
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
                        _passwordController.text = "1Q2w3e4r!",
                        _confirmPasswordController.text = "1Q2w3e4r!"
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
