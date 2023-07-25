import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:swith/models/user_model.dart';
import 'package:swith/screens/login/login_screen.dart';
import 'package:swith/screens/room_list_screen.dart';
import 'package:swith/services/api_service.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);
void main() {
  runApp(const App());
  // logger demo
  // demo();
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  late UserModel user;

  Future<bool> _getJWT() async {
    var isLoggedIn = false;
    //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
    //(데이터가 없을때는 null을 반환을 합니다.)

    var jwt = await storage.read(key: "jwt");
    logger.d("jwt", jwt);

    //user의 정보가 있다면 바로 로그아웃 페이지로 넘어가게 합니다.
    if (jwt != null) {
      // 토큰 검증
      var isAuthenticated = await ApiService.getAuthentication(jwt);
      logger.d("isAuthenticated : $isAuthenticated");
      if (isAuthenticated) {
        logger.d("isAuthenticated : ", isAuthenticated);

        // token verified?
        var userInfo = await storage.read(key: "user_info");
        user = UserModel.fromJson(jsonDecode(userInfo!));

        isLoggedIn = true;
      }
      // token unverified?
      return isLoggedIn;
    } else {
      logger.d("jwt null");

      return isLoggedIn;
    }
  }

  @override
  void initState() {
    //비동기로 flutter secure storage 정보를 불러오는 작업.
    // _getJWT();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Swith',
        theme: ThemeData(
          fontFamily: 'Nanum Square Round',
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.amber, brightness: Brightness.light),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
        themeMode: ThemeMode.system,
        home: FutureBuilder<bool>(
          future: _getJWT(),
          builder: (context, snapshot) {
            // logger.d(snapshot.hasData);
            // logger.d("data", snapshot.data);

            if (snapshot.hasData) {
              return snapshot.data!
                  ? RoomListScreen(
                      user: user,
                    )
                  : LoginScreen(storage: storage);
            } else {
              return const Center(
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    color: Colors.purpleAccent,
                  ),
                ),
              );
            }
          },
        ));
  }
}

void demo() {
  logger.d('Log message with 2 methods');

  loggerNoStack.i('Info message');

  loggerNoStack.w('Just a warning!');

  logger.e('Error! Something bad happened', 'Test Error');

  loggerNoStack.v({'key': 5, 'value': 'something'});

  Logger(printer: SimplePrinter(colors: true)).v('boom');
}
