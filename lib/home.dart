import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
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
