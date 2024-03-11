import 'package:flutter/material.dart';

class Hospital {
  final String name;
  final String location;
  final double rating;
  final String imageUrl;

  Hospital({
    required this.name,
    required this.location,
    required this.rating,
    required this.imageUrl,
  });
}

class HospitalPage extends StatelessWidget {
  final List<Hospital> hospitals = [
    Hospital(
      name: 'Apollo NewDelhi',
      location:
          'Pusa Rd, Radha Soami Satsang, Rajendra Place, New Delhi, Delhi, 110005',
      rating: 4.5,
      imageUrl: 'assets/hospital3.jpeg',
    ),
    Hospital(
      name: 'Fortis Hospitals Group',
      location:
          'No 1/B, 1st Cross St, Gandhi Nagar, Adyar, Chennai, Tamil Nadu 600020',
      rating: 4.8,
      imageUrl: 'assets/hospital2.jpeg',
    ),
    Hospital(
      name: 'Artemis Hospital',
      location: 'Thiruvengadam Nagar, Perungudi, Chennai, Tamil Nadu 600096',
      rating: 4.2,
      imageUrl: 'assets/hospital1.jpeg',
    ),
    Hospital(
      name: 'Wockhardt Hospital',
      location:
          'Akshaya Apartments, 3rd St, Demonte Colony, Alwarpet, Chennai, Tamil Nadu 600018',
      rating: 4.7,
      imageUrl: 'assets/hospital4.jpg',
    ),
    Hospital(
      name: 'Narayana Health Hospital',
      location:
          '18, Tana St, Perumalpet, Purasaiwakkam, Chennai, Tamil Nadu 600007',
      rating: 4.4,
      imageUrl: 'assets/hospital5.jpeg',
    ),
    Hospital(
      name: 'Columbia Asia Hospital',
      location:
          '2H74+M95, 1st Main Rd, Rajajinagar, Bengaluru, Karnataka 560055',
      rating: 4.9,
      imageUrl: 'assets/hospital6.jpg',
    ),
    Hospital(
      name: 'VS Hospital',
      location:
          '815/306, Poonamallee High Rd, Kilpauk, Chennai, Tamil Nadu 600010',
      rating: 4.6,
      imageUrl: 'assets/hospital7.jpg',
    ),
    Hospital(
      name: 'Max Super Speciality Hospital',
      location:
          'I, PLOT NO 20 & 21, Sai Nagar, Porur Gardens, Vanagaram, Tamil Nadu 600095',
      rating: 4.3,
      imageUrl: 'assets/hospital8.jpg',
    ),
    Hospital(
      name: 'Apollo Hospital',
      location:
          'Greams Lane, 21, Greams Rd, Thousand Lights, Chennai, Tamil Nadu 600006',
      rating: 4.8,
      imageUrl: 'assets/hospital9.jpg',
    ),
    Hospital(
      name: 'Medanta Hospital',
      location:
          'Medanta- The Medicity, CH Baktawar Singh Rd, Medicity, Islampur Colony, Sector 38, Gurugram, Haryana 122001',
      rating: 4.5,
      imageUrl: 'assets/hospital10.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospital Page'),
      ),
      body: ListView.builder(
        itemCount: hospitals.length,
        itemBuilder: (context, index) {
          return HospitalCard(hospital: hospitals[index]);
        },
      ),
    );
  }
}

class HospitalCard extends StatelessWidget {
  final Hospital hospital;

  const HospitalCard({Key? key, required this.hospital}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HospitalDetailsPage(hospital: hospital),
            ),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  bottomLeft: Radius.circular(4),
                ),
                image: DecorationImage(
                  image: AssetImage(hospital.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hospital.name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Location: ${hospital.location}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        SizedBox(width: 5),
                        Text(
                          '${hospital.rating}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // View on Map functionality
                      },
                      child: Text('View on Map'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HospitalDetailsPage extends StatelessWidget {
  final Hospital hospital;

  const HospitalDetailsPage({Key? key, required this.hospital})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospital Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(hospital.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hospital.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Location: ${hospital.location}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      SizedBox(width: 5),
                      Text(
                        '${hospital.rating}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // View on Map functionality
                    },
                    child: Text('View on Map'),
                  ),
                  // Additional hospital details can be added here
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HospitalPage(),
  ));
}
