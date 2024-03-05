import 'package:flutter/material.dart';
import 'package:pdl/loginpage.dart'; 
import 'package:pdl/signuppage.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage('assets/logo1.png')),
              SizedBox(height: 30),
              Text(
                "Let's get Started!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(height: 10),
              Text(
                "Login in to enjoy the features we've provided, and stay healthy!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(260, 50),
                  textStyle: TextStyle(fontSize: 24),
                  backgroundColor: Color(0xFF32BFAE),
                  foregroundColor: Colors.white,
                ),
                child: Text("Login"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add your sign up logic here
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder:(context) => SignUpPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(260, 50),
                  textStyle: TextStyle(fontSize: 24),
                  backgroundColor: Color(0xFF32BFAE),
                  foregroundColor: Colors.white,
                ),
                child: Text("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
