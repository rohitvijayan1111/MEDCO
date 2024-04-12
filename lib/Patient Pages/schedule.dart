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
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('Users').doc(userId).snapshots(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (userSnapshot.hasError) {
            return Center(child: Text('Error: ${userSnapshot.error}'));
          } else {
            final isDoctor = userSnapshot.data?.exists ?? false;
            final appointmentsCollection = isDoctor ? 'Doctors/$userId/appointments' : 'Patients/$userId/appointments';

            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection(appointmentsCollection).snapshots(),
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

                  return appointments.isNotEmpty
                      ? ListView.builder(
                          itemCount: appointments.length,
                          itemBuilder: (context, index) {
                            final appointment = appointments[index];
                            final fetchId = isDoctor ? appointment.patientId : appointment.doctorId;
                            final fetchCollection = isDoctor ? 'Patients' : 'Doctors';

                            return FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance.collection(fetchCollection).doc(fetchId).get(),
                              builder: (context, dataSnapshot) {
                                if (dataSnapshot.connectionState == ConnectionState.waiting) {
                                  return ListTile(
                                    title: Text('Loading...'),
                                    subtitle: Text('Date: ${_formatDate(appointment.date)}\nTime: ${appointment.time}'),
                                  );
                                } else if (dataSnapshot.hasError) {
                                  return ListTile(
                                    title: Text('Error loading data'),
                                  );
                                } else {
                                  final data = dataSnapshot.data!.data() as Map<String, dynamic>;
                                  final name = data['name'] ?? 'Unknown';

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
                                        Text('Name: $name'),
                                        Text('Date: ${_formatDate(appointment.date)}'),
                                        Text('Time: ${appointment.time}'),
                                      ],
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        )
                      : Center(
                          child: Text('No appointments found.'),
                        );
                }
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
