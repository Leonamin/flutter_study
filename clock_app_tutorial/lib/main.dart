import 'package:clock_app_tutorial/config/constants/theme_data.dart';
import 'package:clock_app_tutorial/screens/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        backgroundColor: kBackgroundColor,
        fontFamily: 'avenir',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.white,
          ),
          displaySmall: TextStyle(
            color: Colors.white,
          ),
          labelLarge: TextStyle(
            color: Colors.white,
          ),
          labelMedium: TextStyle(
            color: Colors.white,
          ),
          labelSmall: TextStyle(
            color: Colors.white,
          ),
          headlineSmall: TextStyle(
            color: Colors.white,
          ),
          titleLarge: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
          titleMedium: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}
