import 'package:flutter/material.dart';
import 'package:snow_login/screens/homePage.dart'; // Import the HomePage
import 'package:snow_login/screens/profilInfo.dart'; // Import the ProfilePage

class CustomToolbar extends StatelessWidget {
  const CustomToolbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 60.0,
      color: Colors.black.withOpacity(0.7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()), // Navigate to HomePage
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // Handle settings button press
            },
          ),
        ],
      ),
    );
  }
}
