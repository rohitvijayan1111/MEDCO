import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pdl/firebase_options.dart';
import 'package:pdl/Common/Authentication/Auth.dart';
import 'package:pdl/Common/Authentication/loginpage.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          AnimatedSplashScreen(
            splash: 'assets/image.png',
            splashIconSize: double.infinity,
            duration: 3000,
            nextScreen: AuthPage(),
            backgroundColor: const Color(0xFF32BFAE),
            splashTransition: SplashTransition.scaleTransition,
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment(0.0, 0.6),
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.white,
                size: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
