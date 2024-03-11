import 'package:flutter/material.dart';

class Doctor {
  final String name;
  final String specialist;
  final String hospital;
  final double rating;
  final String imageUrl;

  Doctor({
    required this.name,
    required this.specialist,
    required this.hospital,
    required this.rating,
    required this.imageUrl,
  });
}

class DoctorsPage extends StatelessWidget {
  final List<Doctor> doctors = [
    Doctor(
      name: 'Dr. Swetha',
      specialist: 'Cardiologist',
      hospital: 'BLK Super Speciality Hospital',
      rating: 4.5,
      imageUrl: 'assets/doctor1.png',
    ),
    Doctor(
      name: 'Dr. Veeraragavan',
      specialist: 'Pediatrician',
      hospital: 'Fortis Hospitals Group',
      rating: 4.8,
      imageUrl: 'assets/doctor2.png',
    ),
    Doctor(
      name: 'Dr. Sheethal',
      specialist: 'Dermatologist',
      hospital: 'Artemis Hospital',
      rating: 4.3,
      imageUrl: 'assets/doctor3.png',
    ),
    Doctor(
      name: 'Dr. Kishore',
      specialist: 'Ophthalmologist',
      hospital: 'Wockhardt Hospital',
      rating: 4.6,
      imageUrl: 'assets/doctor4.png',
    ),
    Doctor(
      name: 'Dr. Meghna Shreeharan',
      specialist: 'Orthopedic Surgeon',
      hospital: 'Narayana Health Hospital',
      rating: 4.9,
      imageUrl: 'assets/doctor5.png',
    ),
    Doctor(
      name: 'Dr. Arjun',
      specialist: 'Neurologist',
      hospital: 'Columbia Asia Hospital',
      rating: 4.7,
      imageUrl: 'assets/doctor6.png',
    ),
    Doctor(
      name: 'Dr. Saraah Goshal',
      specialist: 'Psychiatrist',
      hospital: 'VS Hospital',
      rating: 4.2,
      imageUrl: 'assets/doctor7.png',
    ),
    Doctor(
      name: 'Dr. Meera Rajesh',
      specialist: 'Gynecologist',
      hospital: 'Max Super Speciality Hospital',
      rating: 4.4,
      imageUrl: 'assets/doctor8.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctors Page'),
      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          return DoctorCard(doctor: doctors[index]);
        },
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
        leading: Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(doctor.imageUrl),
          ),
        ),
        title: Text(
          doctor.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(doctor.specialist),
            Text(doctor.hospital),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16),
                SizedBox(width: 5),
                Text('${doctor.rating}'),
              ],
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorDetailsPage(doctor: doctor),
            ),
          );
        },
      ),
    );
  }
}

class DoctorDetailsPage extends StatelessWidget {
  final Doctor doctor;

  const DoctorDetailsPage({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(doctor.imageUrl),
              ),
            ),
            SizedBox(height: 20),
            Text(
              doctor.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Specialist: ${doctor.specialist}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Hospital: ${doctor.hospital}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 20),
                SizedBox(width: 5),
                Text(
                  '${doctor.rating}',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle booking appointment
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Book Appointment'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        9,
                        (index) => TextButton(
                          onPressed: () {
                            // Handle appointment time selection
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Appointment Time'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                        'You have selected ${index + 9}:00 AM'),
                                    SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Handle payment options
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              PaymentOptionDialog(),
                                        );
                                      },
                                      child: Text('Book Now'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Color.fromARGB(255, 49, 196, 181),
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Text('${index + 9}:00 AM'),
                          style: TextButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 49, 196, 181),
                          ),
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Book Appointment'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 49, 196, 181),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentOptionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Payment Option'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () {
              // Handle credit card payment
              Navigator.popUntil(context, ModalRoute.withName('/'));
              showDialog(
                context: context,
                builder: (context) => CreditCardPaymentDialog(),
              );
            },
            child: Text('Credit Card'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 49, 196, 181),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle debit card payment
              Navigator.popUntil(context, ModalRoute.withName('/'));
              showDialog(
                context: context,
                builder: (context) => DebitCardPaymentDialog(),
              );
            },
            child: Text('Debit Card'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 49, 196, 181),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle UPI payment
              Navigator.popUntil(context, ModalRoute.withName('/'));
              showDialog(
                context: context,
                builder: (context) => UpiPaymentDialog(),
              );
            },
            child: Text('UPI'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 49, 196, 181),
            ),
          ),
        ],
      ),
    );
  }
}

class CreditCardPaymentDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Credit Card Payment'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Credit Card Number'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Name on Card'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Expiration Date'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'CVV/CVC'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Billing Address'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Amount to Pay'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle credit card payment processing
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Payment Success'),
                  content: Text('Your payment was successful!'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: Text('Pay Now'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 49, 196, 181),
            ),
          ),
        ],
      ),
    );
  }
}

class DebitCardPaymentDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Debit Card Payment'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Debit Card Number'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Name on Card'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Expiration Date'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'CVV/CVC'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Billing Address'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Amount to Pay'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle debit card payment processing
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Payment Success'),
                  content: Text('Your payment was successful!'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: Text('Pay Now'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 49, 196, 181),
            ),
          ),
        ],
      ),
    );
  }
}

class UpiPaymentDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('UPI Payment'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'UPI ID or VPA'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Amount to Pay'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle UPI payment processing
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Payment Success'),
                  content: Text('Your payment was successful!'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: Text('Pay Now'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 49, 196, 181),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DoctorsPage(),
  ));
}
