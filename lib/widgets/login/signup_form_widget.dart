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
  String errorMessage = "";

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
      return '이메일 형식에 맞게 입력해주세요';
    }
    return null;
  }

  //validator for name
  String? nameValidator(value) {
    RegExp nameValid = RegExp(r"^[가-힣a-zA-Z]{2,15}");
    String name = value.trim();

    if (!nameValid.hasMatch(name)) {
      return '알맞은 이름을 입력해주세요';
    }
    return null;
  }

  //validator for password
  String? passwordValidator(value) {
    RegExp passwordValid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
    String password = value.trim();

    if (!passwordValid.hasMatch(password)) {
      return '비밀번호 형식에 맞게 입력해주세요';
    }
    return null;
  }

  //validator for confirm password
  String? confirmPasswordValidator(value) {
    String confirmPassword = value.trim();

    logger.d(confirmPassword != _passwordController.text);
    if (confirmPassword != _passwordController.text) {
      return '비밀번호가 일치하지 않습니다';
    }
    return null;
  }

  void onSignupPressed() async {
    if (_formKey.currentState!.validate()) {
      var response = await ApiService.postSignUp(_emailController.text,
          _passwordController.text, _nameController.text);

      if (response.runtimeType == String) {
        _visibility = true;
        errorMessage = response;
        setState(() {});
      } else {
        if (response.statusCode == 200) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('회원가입 성공!')),
            );
            Navigator.of(context).pop();
          }
        } else {
          _visibility = true;
          errorMessage = "같은 이메일이 이미 존재합니다";
          setState(() {});
        }
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
          const Text("계정을 생성하세요"),
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
                labelText: "이메일",
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
                labelText: "이름",
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
                labelText: "비밀번호",
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
              labelText: "비밀번호 확인",
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
                child: Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.redAccent),
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
                    backgroundColor: const Color(0xffFF9494),

                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  child: const Text(
                    '회원가입',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
                // const SizedBox(
                //   height: 16,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     ElevatedButton(
                //       onPressed: () => {
                //         _emailController.text = "son7@gmail.com",
                //         _passwordController.text = "1Q2w3e4r!",
                //         _confirmPasswordController.text = "1Q2w3e4r!"
                //       },
                //       style: ElevatedButton.styleFrom(
                //           padding: const EdgeInsets.symmetric(
                //               vertical: 20, horizontal: 34)),
                //       child: const Text('손흥민'),
                //     ),
                //     const SizedBox(
                //       width: 8,
                //     ),
                //     ElevatedButton(
                //       onPressed: () => {
                //         _emailController.text = "hgd@gmail.com",
                //         _passwordController.text = "1Q2w3e4r!",
                //         _confirmPasswordController.text = "1Q2w3e4r!"
                //       },
                //       style: ElevatedButton.styleFrom(
                //           padding: const EdgeInsets.symmetric(
                //               vertical: 20, horizontal: 34) // NEW
                //           ),
                //       child: const Text('홍길동'),
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
