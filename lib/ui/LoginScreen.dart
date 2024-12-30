import 'package:das_app/ui/home/DashboardScreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username',
                  border: OutlineInputBorder(), // Add outline border
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0), // Space between username and password fields
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password',
                  border: OutlineInputBorder(), // Add outline border
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0), // Space between password field and button

          SizedBox( // Wrap the button with SizedBox
            width: double.infinity, // Make button width match parent
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Set button color to blue
                padding: const EdgeInsets.symmetric(vertical: 16.0), // Adjust padding as needed
              ),
              onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process login
                    String username = _usernameController.text;
                    String password = _passwordController.text;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const DashboardScreen()),
                    );
                  }
                },
                child: const Text('Login', style: TextStyle(color: Colors.white),),
              )
          ),
              const SizedBox(height: 16.0), // Space below the button (optional)

            ],
          ),
        ),
      ),
    );
  }
}