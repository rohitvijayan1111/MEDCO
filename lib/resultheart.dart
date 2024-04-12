import 'package:flutter/material.dart';

class ResultHeart extends StatelessWidget {
  final bool hasHeartDisease;

  const ResultHeart({Key? key, required this.hasHeartDisease}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Heart Disease Prediction Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              hasHeartDisease
                  ? 'You Might Have Heart Disease'
                  : 'You May Not Have Heart Disease',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
