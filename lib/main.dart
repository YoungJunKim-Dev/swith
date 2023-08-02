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

    var jwt = await storage.read(key: "jwt");

    //토큰이 null이 아니면 토큰을 검증하고 토큰이 null이면 로그인 페이지로.
    if (jwt != null) {
      // 토큰 검증
      var isAuthenticated = await ApiService.getAuthentication(jwt);
      logger.d("isAuthenticated : $isAuthenticated");
      if (isAuthenticated) {
        // token verified?
        var userInfo = await storage.read(key: "user_info");
        user = UserModel.fromJson(jsonDecode(userInfo!));

        isLoggedIn = true;
      }
      // token unverified?
      return isLoggedIn;
    } else {
      //토큰 null
      return isLoggedIn;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Swith',
        theme: ThemeData(
          fontFamily: 'Nanum Square Round',
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xffFF9494), brightness: Brightness.light),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xff00ADB5),
                brightness: Brightness.dark)),
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
