import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:pdl/Auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    debugShowCheckedModeBanner:false;
    return MaterialApp(
      debugShowCheckedModeBanner:false,
        home: AnimatedSplashScreen(
      splash: 'assets/image.png',
      splashIconSize: double.infinity,
      duration: 5000,
      nextScreen: const Auth(),
      backgroundColor: const Color(0xFF32BFAE),
      splashTransition: SplashTransition.scaleTransition,
    ));
  }
}

