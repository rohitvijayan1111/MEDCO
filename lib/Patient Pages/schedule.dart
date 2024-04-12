import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String doctorId;
  final String patientId;
  final DateTime date;
  final String time;

  Appointment({
    required this.doctorId,
    required this.patientId,
    required this.date,
    required this.time,
  });
}

class SchedulePage extends StatelessWidget {
  final String userId;

  SchedulePage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Appointments'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Doctors') // Doctors collection
            .doc(userId)
            .collection('appointments')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final appointments = snapshot.data!.docs.map((doc) {
              final appointmentData = doc.data() as Map<String, dynamic>;
              return Appointment(
                doctorId: appointmentData['doctorId'],
                patientId: appointmentData['patientId'],
                date: (appointmentData['date'] as Timestamp).toDate(),
                time: appointmentData['time'],
              );
            }).toList();

            return ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('Patients') // Patients collection
                      .doc(appointment.patientId)
                      .get(),
                  builder: (context, patientSnapshot) {
                    if (patientSnapshot.connectionState == ConnectionState.waiting) {
                      return ListTile(
                        title: Text('Loading...'),
                        subtitle: Text('Date: ${_formatDate(appointment.date)}\nTime: ${appointment.time}'),
                      );
                    } else if (patientSnapshot.hasError) {
                      return ListTile(
                        title: Text('Error loading data'),
                      );
                    } else {
                      final patientData = patientSnapshot.data!.data() as Map<String, dynamic>;
                      final patientName = patientData['name'] ?? 'Unknown';

                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                            Text('Patient: $patientName'),
                            Text('Date: ${_formatDate(appointment.date)}'),
                            Text('Time: ${appointment.time}'),
                          ],
                        ),
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
