import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pdl/Patient%20Pages/home.dart';

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

class DoctorAppointment extends StatefulWidget {
  final User? user = FirebaseAuth.instance.currentUser;
  final Doctor doctor;

  DoctorAppointment({required this.doctor});

  @override
  _DoctorAppointmentState createState() => _DoctorAppointmentState();
}

class _DoctorAppointmentState extends State<DoctorAppointment> {
  TimeOfDay? _selectedTime;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book Appointment with ${widget.doctor.name}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(
                "Doctor Name: ${widget.doctor.name}",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(
                "Specialization: ${widget.doctor.specialization}",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Image.asset(
              widget.doctor.imageUrl,
              fit: BoxFit.fitHeight,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80.0),
              child: Text(
                'Select a date and time',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _selectedDate = pickedDate;
                      });
                    }
                  },
                  child: Text('Select Date'),
                ),
                if (_selectedDate != null)
                  ElevatedButton(
                    onPressed: () async {
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          _selectedTime = pickedTime;
                        });
                      }
                    },
                    child: Text('Select Time'),
                  ),
              ],
            ),
            if (_selectedDate != null && _selectedTime != null)
              Padding(
                padding: const EdgeInsets.only(left: 90.0),
                child: Text(
                    'Selected Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year} ${_selectedTime!.hour}:${_selectedTime!.minute}'),
              ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 130.0),
              child: ElevatedButton(
                child: Text("Book now"),
                onPressed: _selectedDate == null || _selectedTime == null
                    ? null
                    : () async {
                        WriteBatch batch = FirebaseFirestore.instance.batch();

                        // Document references for the doctor and patient appointments
                        DocumentReference doctorAppointmentRef =
                            FirebaseFirestore.instance
                                .collection('Doctors')
                                .doc(widget.doctor.userId)
                                .collection('appointments')
                                .doc();

                        DocumentReference patientAppointmentRef =
                            FirebaseFirestore.instance
                                .collection('Patients')
                                .doc(widget.user!.uid)
                                .collection('appointments')
                                .doc();

                        // Add appointment data to the batch
                        batch.set(doctorAppointmentRef, {
                          "doctorId": widget.doctor.userId,
                          "patientId": widget.user!.uid,
                          "date": _selectedDate,
                          "time": _selectedTime.toString(),
                        });

                        batch.set(patientAppointmentRef, {
                          "doctorId": widget.doctor.userId,
                          "patientId": widget.user!.uid,
                          "date": _selectedDate,
                          "time": _selectedTime.toString(),
                        });

                        try {
                          // Commit the batch
                          await batch.commit();

                          // Show success dialog
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Appointment Booked'),
                              content:
                                  Text('Your appointment has been booked!'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()),
                                    );
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } catch (error) {
                          print('Error adding appointments: $error');
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 49, 196, 181),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PatientDoctorListing extends StatelessWidget {
  const PatientDoctorListing({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Doctors'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Doctors').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView.builder(
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
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorAppointment(
                            doctor: doctor,
                          ),
                        ),
                      );
                    },
                    child: DoctorCard(doctor: doctor),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  const DoctorCard({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(doctor.imageUrl),
        ),
        title: Text(
          doctor.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Specialization: ${doctor.specialization}'),
        // Add more details or actions as needed
      ),
    );
  }
}
