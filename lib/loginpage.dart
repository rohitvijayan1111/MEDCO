// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdl/Components/MyTextField.dart';
import 'package:pdl/Components/my_button.dart';
import 'package:pdl/signuppage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  void wrongEmailMessage(String s) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(s),
          );
        });
  }

  void signUserIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: usernameController.text, password: passwordController.text)
        .then((value) {
      Navigator.pop(context);
    }).onError((error, StackTrace) {
      wrongEmailMessage(error.toString().split("]").elementAt(1).trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                const SizedBox(
                  height: 40,
                ),
                Image(image: AssetImage("assets/logo_login.png")),
                Text(
                  "Welcome back you\'ve been missed!",
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                const SizedBox(
                  height: 25,
                ),
                MyTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Text(
                          "Sign Up Instead",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => SignUpPage(),
                                  transitionDuration:
                                      Duration(milliseconds: 0)));
                        },
                      ),
                      Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                MyButton(
                  onTap: signUserIn,
                  buttonname: "Sign In",
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "Or Continue With",
                            style: TextStyle(color: Colors.grey[700]),
                          )),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: Container(
                  width: 350,
                  height: 70,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey[200]),
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 60,
                        ),
                        Image.asset(
                          "assets/google.png",
                          height: 30,
                        ),
                        Text(
                          "Sign In With Google",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ));
  }
}
