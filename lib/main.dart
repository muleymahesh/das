import 'package:das_app/data/model/Product.dart';
import 'package:das_app/data/model/user.dart';
import 'package:das_app/di/DependencyInjection.dart';
import 'package:das_app/ui/SplashScreen.dart';
import 'package:flutter/material.dart';

import 'data/db/objectbox.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  DependencyInjection.configure();

  runApp(MaterialApp(
    title: 'My App',
    theme: ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue, // Set your desired blue color here
      ),
    ),
    home: const SplashScreen(),
  ));
}
