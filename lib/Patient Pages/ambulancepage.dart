import 'package:flutter/material.dart';

class AmbulancePage extends StatelessWidget {
  const AmbulancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ambulance Page'),
      ),
      body: Center(
        child: Text('This is the Ambulance Page'),
      ),
    );
  }
}
