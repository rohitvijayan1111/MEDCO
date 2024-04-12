import 'package:flutter/material.dart';

class LearnMorePage extends StatelessWidget {
  const LearnMorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn More'),
        backgroundColor: Color(0xFF32BFAE),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Our Health App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF32BFAE),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Purpose:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF32BFAE),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Our app is designed to provide a comprehensive solution for all your health-related needs. From finding doctors and hospitals to diagnosing diseases, we aim to make healthcare accessible and convenient for everyone.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Special Features:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF32BFAE),
              ),
            ),
            SizedBox(height: 10),
            Text(
              '- Find the right doctor or hospital near you\n'
              '- Get expert diagnosis for common diseases\n'
              '- Quick access to emergency services like ambulances\n'
              '- Personalized health recommendations and reminders\n',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
