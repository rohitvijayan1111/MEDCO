import 'package:flutter/material.dart';
import 'package:pdl/doctorspage.dart';
import 'package:pdl/diagonisispage.dart';
import 'package:pdl/ambulancepage.dart';
import 'package:pdl/hospitalpage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Expanded(
              child: Text(
                'Find desired health solution',
                style: TextStyle(
                  color: Color(0xFF32BFAE),
                  fontSize: 16,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                // Handle notification tap
              },
              color: Color(0xFF32BFAE),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search doctors, articles, drugs',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height: 10), // Added SizedBox for spacing
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HealthButton(
                    iconAsset: 'assets/doctors.png',
                    label: 'Doctors',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DoctorsPage()),
                      );
                    },
                  ),
                  HealthButton(
                    iconAsset: 'assets/hospital.png',
                    label: 'Hospital',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HospitalPage()),
                      );
                    },
                  ),
                  HealthButton(
                    iconAsset: 'assets/diagonisis.png',
                    label: 'Diagnosis',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DiagonisisPage()),
                      );
                    },
                  ),
                  HealthButton(
                    iconAsset: 'assets/ambulance.png',
                    label: 'Ambulance',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AmbulancePage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: Center(
              child: Text('Welcome to Home Page'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset('assets/home.png', width: 24, height: 24),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/schedule.png', width: 24, height: 24),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/chat.png', width: 24, height: 24),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/profile.png', width: 24, height: 24),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Color(0xFF32BFAE),
        onTap: (int index) {},
      ),
    );
  }
}

class HealthButton extends StatelessWidget {
  final String iconAsset;
  final String label;
  final VoidCallback onPressed;

  const HealthButton({
    Key? key,
    required this.iconAsset,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Image.asset(
              iconAsset,
              width: 24,
              height: 24,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).textTheme.bodyText1?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
