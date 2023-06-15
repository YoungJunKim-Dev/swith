import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("아이디"),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            color: Colors.green,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("비밀번호"),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            color: Colors.amber,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () => {}, child: const Text("홍")),
              ElevatedButton(onPressed: () => {}, child: const Text("길")),
              ElevatedButton(onPressed: () => {}, child: const Text("동")),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.blueGrey,
            child: const Center(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "로그인",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 30),
              ),
            )),
          ),
        ],
      ),
    );
  }
}
