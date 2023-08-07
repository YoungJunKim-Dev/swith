import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:swith/models/user_model.dart';
import 'package:swith/screens/login/login_screen.dart';
import 'package:swith/screens/room_list_screen.dart';
import 'package:swith/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var logger = Logger();
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
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
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
          return const Scaffold(
            body: Center(
              child: SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  color: Color(0xffFF9494),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
