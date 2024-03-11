import 'package:flutter/material.dart';

class DiagonisisPage extends StatelessWidget {
  const DiagonisisPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diagnosis Page'),
      ),
      body: Center(
        child: Text('This is the Diagnosis Page'),
      ),
    );
  }
}
