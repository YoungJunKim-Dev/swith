import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final String userName, userEmail;
  const Profile({super.key, required this.userEmail, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const CircleAvatar(
          radius: 60,
          child: Icon(
            Icons.person_outline_rounded,
            size: 100,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              userEmail,
              style: const TextStyle(fontSize: 20),
            )
          ],
        )
      ],
    );
  }
}
