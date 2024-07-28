import 'package:flutter/material.dart';
import 'package:snow_login/screens/homePage.dart'; // Import the HomePage
import 'package:snow_login/screens/profilInfo.dart'; // Import the ProfilePage

class CustomToolbar extends StatefulWidget {
  const CustomToolbar({Key? key}) : super(key: key);

  @override
  _CustomToolbarState createState() => _CustomToolbarState();
}

class _CustomToolbarState extends State<CustomToolbar> {
  String _activeItem = '';

  void _setActiveItem(String item) {
    setState(() {
      _activeItem = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 60.0,
      color: Colors.black.withOpacity(0.7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildToolbarItem('home', Icons.home, 'Home', const HomePage()),
          _buildToolbarItem('profile', Icons.account_circle, 'Profile', const ProfilePage()),
          _buildToolbarItem('settings', Icons.settings, 'Settings', null), // Replace 'null' with your settings page if any
        ],
      ),
    );
  }

  Widget _buildToolbarItem(String itemName, IconData icon, String text, Widget? page) {
    bool isActive = _activeItem == itemName;
    return GestureDetector(
      onTap: () {
        _setActiveItem(itemName);
        if (page != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: isActive ? Colors.red[900] : Colors.transparent,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: isActive
              ? Text(
                  text,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                )
              : Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}
