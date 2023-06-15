import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(
          Icons.person_2,
          size: 120,
          color: Colors.amber,
        ),
        SizedBox(
          width: 40,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "홍길동",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
            ),
            SizedBox(
              height: 20,
            ),
            Text("hgd@gmail.com")
          ],
        )
      ],
    );
  }
}
