import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:swith/widgets/bottom_navigaton_bar_widget.dart';
import 'package:swith/widgets/login_form_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  late String? jwt;
  bool isVerified = true;

  @override
  void initState() {
    super.initState();
    //비동기로 flutter secure storage 정보를 불러오는 작업.
    _getJWT();
  }

  _getJWT() async {
    //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
    //(데이터가 없을때는 null을 반환을 합니다.)
    jwt = await storage.read(key: "jwt");
    print(jwt);

    //user의 정보가 있다면 바로 로그아웃 페이지로 넝어가게 합니다.
    if (jwt != null) {
      // 토큰 검증
      // token unverified?
      if (isVerified) {
        if (context.mounted) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const MyBottomNavigationBar()));
        }
      }
      // token verified?
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: LoginForm(
                storage: storage,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
