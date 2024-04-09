import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pdl/Patient%20Pages/home.dart';

class DoctorDetails extends StatefulWidget {
  DoctorDetails({super.key});
  final User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _specializationController =
      TextEditingController();
  final TextEditingController _hospitalController = TextEditingController();

  @override
  _DoctorDetailsState createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextFormField(
              controller: widget._nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Email',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextFormField(
              controller: widget._emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Gender',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextFormField(
              controller: widget._genderController,
              decoration: InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Specialization',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextFormField(
              controller: widget._specializationController,
              decoration: InputDecoration(
                labelText: 'Specialization',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Hospital',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextFormField(
              controller: widget._hospitalController,
              decoration: InputDecoration(
                labelText: 'Hospital',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 130.0),
              child: ElevatedButton(
                onPressed: () {
                  // Add doctor details to Firestore
                  FirebaseFirestore.instance
                      .collection('Doctors')
                      .doc(widget.user!.uid)
                      .set({
                    'name': widget._nameController.text,
                    'email': widget._emailController.text,
                    'specialization': widget._specializationController.text,
                    'hospital': widget._hospitalController.text,
                  }).then((value) {
                    widget._nameController.clear();
                    widget._emailController.clear();
                    widget._specializationController.clear();
                    widget._hospitalController.clear();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }).catchError((error) {
                    print('Error adding doctor details: $error');
                  });
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
