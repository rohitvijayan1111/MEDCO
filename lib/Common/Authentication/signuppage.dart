// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pdl/Components/MyTextField.dart';
import 'package:pdl/Components/my_button.dart';
import 'package:pdl/Doctor%20Pages/doctordetails.dart';
import 'package:pdl/Patient%20Pages/home.dart';
import 'package:pdl/Common/Authentication/loginpage.dart';
import 'package:pdl/Patient%20Pages/patientdetails.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final roleController = TextEditingController();
  void wrongEmailMessage(String s) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(s),
          );
        });
  }

  void signUpUser() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: usernameController.text, password: passwordController.text);
      Navigator.pop(context);
      if (roleController.text.trim().toLowerCase() == 'patient') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PatientDetails()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DoctorDetails()));
      }
    } catch (error) {
      Navigator.pop(context);
      wrongEmailMessage(error.toString().split("]").elementAt(1).trim());
    }
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
                  "Begin Your Journey With Us!!",
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
                SizedBox(height: 20),
                MyTextField(
                    controller: roleController,
                    hintText: 'Role',
                    obscureText: false),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        child: Text(
                          "Sign In Instead",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => LoginPage(),
                                transitionDuration: Duration(milliseconds: 0),
                              ));
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                MyButton(
                  buttonname: "Sign Up",
                  onTap: signUpUser,
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
