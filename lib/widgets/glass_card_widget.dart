import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  final Widget child;

  const GlassCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        //you can get rid of below line also
        borderRadius: BorderRadius.circular(14.0),
        //below line is for rectangular shape
        shape: BoxShape.rectangle,
        //you can change opacity with color here(I used black) for rect
        color: Colors.white.withOpacity(0.1),
        //I added some shadow, but you can remove boxShadow also.
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black38,
            blurRadius: 5.0,
            offset: Offset(5.0, 5.0),
          ),
        ],
      ),
      child: child,
    );
  }
}
