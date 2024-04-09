import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdl/Patient%20Pages/home.dart';

class PatientDetails extends StatefulWidget {
  final User? user = FirebaseAuth.instance.currentUser;
  PatientDetails({super.key});
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _medicalHistoryController =
      TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();
  final TextEditingController _medicationsController = TextEditingController();

  @override
  _PatientDetailsState createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Details Form'),
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
              'Phone',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextFormField(
              controller: widget._phoneController,
              decoration: InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Date of Birth',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextFormField(
              controller: widget._dobController,
              decoration: InputDecoration(
                labelText: 'Date of Birth',
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
              'Address',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextFormField(
              controller: widget._addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Medical History',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextFormField(
              controller: widget._medicalHistoryController,
              decoration: InputDecoration(
                labelText: 'Medical History',
                border: OutlineInputBorder(),
                hintMaxLines: null,
              ),
              maxLines: null,
            ),
            SizedBox(height: 16),
            Text(
              'Allergies',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextFormField(
              controller: widget._allergiesController,
              decoration: InputDecoration(
                labelText: 'Allergies',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Current Medications',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextFormField(
              controller: widget._medicationsController,
              decoration: InputDecoration(
                labelText: 'Current Medications',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 120.0),
              child: ElevatedButton(
                onPressed: () {
                  // Add patient details to Firestore
                  FirebaseFirestore.instance
                      .collection('Patients')
                      .doc(widget.user!.uid)
                      .set({
                    'name': widget._nameController.text,
                    'email': widget._emailController.text,
                    'phone': widget._phoneController.text,
                    'dob': widget._dobController.text,
                    'gender': widget._genderController.text,
                    'address': widget._addressController.text,
                    'medical_history': widget._medicalHistoryController.text,
                    'allergies': widget._allergiesController.text,
                    'medications': widget._medicationsController.text,
                  }).then((value) {
                    widget._nameController.clear();
                    widget._emailController.clear();
                    widget._phoneController.clear();
                    widget._dobController.clear();
                    widget._genderController.clear();
                    widget._addressController.clear();
                    widget._medicalHistoryController.clear();
                    widget._allergiesController.clear();
                    widget._medicationsController.clear();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }).catchError((error) {
                    print('Error adding patient details: $error');
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
