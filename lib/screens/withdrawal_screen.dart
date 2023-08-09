import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:swith/models/user_model.dart';
import 'package:swith/services/api_service.dart';

class WithdrawalScreen extends StatefulWidget {
  const WithdrawalScreen({super.key});

  @override
  State<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late UserModel user;

  String emailInput = "";
  String passwordInput = "";
  bool _isObscured = true;
  //error 문구 visibility 변수
  bool _visibility = false;
  String errorMessage = "";

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
      return '이메일 형식에 맞게 입력해주세요';
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

  void onWithDrawalPressed(context) async {
    if (_formKey.currentState!.validate()) {
      var jwt = await storage.read(key: "jwt");

      //토큰이 null이 아니면 토큰을 검증하고 토큰이 null이면 로그인 페이지로.
      if (jwt != null) {
        // 토큰 검증
        var isSucceeded = await ApiService.deleteUser(
          jwt,
          _emailController.text,
          _passwordController.text,
        );

        if (isSucceeded.runtimeType == String) {
          errorMessage = isSucceeded;
          _visibility = true;
          setState(() {});
        } else {
          if (isSucceeded) {
            storage.delete(key: "jwt");
            if (context.mounted) {
              Navigator.popUntil(context, ModalRoute.withName("/"));
            }
          } else {
            errorMessage = "이메일 또는 비밀번호를 잘못 입력하셨습니다";
            _visibility = true;
            setState(() {});
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("회원탈퇴")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              const Text("회원탈퇴를 위해 이메일과 비밀번호를 입력해주세요"),
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
                    labelText: "이메일",
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
              Center(
                child: Visibility(
                    visible: _visibility,
                    child: Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.redAccent),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
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
