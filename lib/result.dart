import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final double output;
  var text = "";
  Result({super.key, required this.output}) {
    if (output > 0.5) {
      text = "You Might Have Diabetes";
    } else {
      text = "You May Not Have Diabetes";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        title: const Text(
          "Diabetes Test",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF32BFAE),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: AssetImage("assets/photoresult.png")),
            Center(
              child: Image(
                image: AssetImage("assets/result_doctor.png"),
              ),
            ),
            Center(
                child: Text(
              text,
              style: TextStyle(fontSize: 24),
            )),
            Center(
                child: Text(
              "Warning: This is an Predictive Test!",
              style: TextStyle(fontSize: 20, color: Colors.red),
            )),
          ],
        ),
      ),
    );
  }
}
