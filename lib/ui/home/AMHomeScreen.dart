import 'package:flutter/material.dart';

import 'MyTeamScreen.dart';

class AMHomeScreen extends StatelessWidget {
  AMHomeScreen({super.key});

  final ButtonStyle _buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFFDD120),
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    textStyle: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AM Home Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: _buttonStyle,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyTeamScreen()),
                  );
                },
                child: const Text('My Team'),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: _buttonStyle,
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => StockRequestsScreen()),
                  // );
                },
                child: const Text('Stock Requests'),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: _buttonStyle,
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => DepositionRequestsScreen()),
                  // );
                },
                child: const Text('Deposition Requests'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}