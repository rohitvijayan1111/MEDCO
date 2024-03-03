import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image(image: AssetImage('assets/logo1.png')),
        Text("Let's get Started!"),
        Text(
          "Login in to enjoy the features we've provided, and stay healthy!",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
      ])),
    );
  }
}
