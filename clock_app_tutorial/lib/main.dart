import 'package:clock_app_tutorial/constants.dart';
import 'package:clock_app_tutorial/home_page.dart';
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
      ),
      home: HomePage(),
    );
  }
}
