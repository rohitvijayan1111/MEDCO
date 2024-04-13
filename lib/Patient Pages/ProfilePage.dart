import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  final String userId;
  final String collectionName;
  final bool isDoctor;
  final String? imageUrl;
  const ProfilePage({
    Key? key,
    required this.userId,
    required this.collectionName,
    required this.isDoctor,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection(collectionName)
            .doc(userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final profileData = snapshot.data!.data();
            if (profileData == null) {
              return Center(child: Text('Error: Profile data not found'));
            }
            final name =
                (profileData as Map<String, dynamic>)['name'] ?? 'Unknown';
            final gender =
                (profileData as Map<String, dynamic>)['gender'] ?? 'Unknown';
            final defaultMaleImage = 'assets/maledoc.jpg';
            final defaultFemaleImage = 'assets/femaledoc.jpeg';

            return Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (imageUrl != null)
                        CircleAvatar(
                          backgroundImage: NetworkImage(imageUrl!),
                          radius: 40,
                        ),
                      if (imageUrl == null)
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            gender == 'Male'
                                ? defaultMaleImage
                                : defaultFemaleImage,
                          ),
                          radius: 40,
                        ),
                      SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name: $name',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Gender: $gender',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
