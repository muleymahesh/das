import 'package:das_app/ui/home/HomeScreen.dart';
import 'package:flutter/material.dart';

import '../profile/ProfileScreen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0; // Index of the currently selected tab
  String _appBarTitle = 'Dashboard'; // Initial title

  // List of screens to display for each tab
  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(), // Home tab content
    const ProfileScreen(), // Profile tab content
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _appBarTitle = _selectedIndex == 0 ? 'Dashboard' : 'Profile';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle), // Use the updated title
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue, // Customize the selected item color
        onTap: _onItemTapped,
      ),
    );
  }
}