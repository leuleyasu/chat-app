import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Center(
child: Text("fast chat", style:  TextStyle(fontWeight: FontWeight.bold,fontSize: 25), ),
        )
      ],
    );
  }
}