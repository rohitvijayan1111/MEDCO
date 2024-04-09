import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorTile extends StatelessWidget {
  final String name;
  final String specialization;
  final String imageUrl;

  DoctorTile(
      {required this.name,
      required this.specialization,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    specialization,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Doctors').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var doctorData =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                var doctor = Doctor(
                    name: doctorData['name'],
                    specialization: doctorData['specialization'],
                    imageUrl: doctorData['Gender'] == 'Male'
                        ? 'assets/maledoc.jpg'
                        : 'assets/femaledoc.jpeg',
                    userId: snapshot.data!.docs[index].id);
                return DoctorTile(
                  name: doctor.name,
                  specialization: doctor.specialization,
                  imageUrl: doctor.imageUrl,
                );
              },
            ),
          );
        }
      },
    );
  }
}

class Doctor {
  final String name;
  final String specialization;
  final String imageUrl;
  final String userId;

  Doctor({
    required this.name,
    required this.specialization,
    required this.imageUrl,
    required this.userId,
  });
}
