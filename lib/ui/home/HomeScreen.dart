import 'package:das_app/ui/bookings/MyBookingsScreen.dart';
import 'package:flutter/material.dart';

import '../product/ProductsScreen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ButtonStyle _buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFFDD120),
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    textStyle: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold), // Set font size here
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity, // Make button width match parent
            child: ElevatedButton(
              style: _buttonStyle,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                 ProductsScreen(productType: 'freshsold')),
                );
              },
              child: const Text('Fresh Sold'),
            ),
          ),
          const SizedBox(height: 16.0), // Add spacing between buttons
          SizedBox(
            width: double.infinity, // Make button width match parent
            child: ElevatedButton(
              style: _buttonStyle,

              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                   ProductsScreen(productType: 'booking'), ),
                );
              },
              child: const Text('Booking'),
            ),
          ),
          const SizedBox(height: 16.0), // Add spacing between buttons
          SizedBox(
            width: double.infinity, // Make button width match parent
            child: ElevatedButton(
              style: _buttonStyle,

              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                  const MyBookingsScreen(from: 'bookingsold'), ),
                );
              },
              child: const Text('Booking Sold'),
            ),
          ),
        ],
      ),
    );
  }
}