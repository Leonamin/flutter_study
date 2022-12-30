import 'package:auth_screen/constants.dart';
import 'package:auth_screen/welcome_screen.dart';
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
      title: 'Auth Screen 1',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
        // https://stackoverflow.com/questions/72271461/cannot-mix-2018-and-2021-terms-in-call-to-texttheme-constructor
        // 2018과 2021 규격을 섞어쓰면 안된다.
        // button은 labelLarge로 대체되었다. https://api.flutter.dev/flutter/material/TextTheme/button.html
        textTheme: const TextTheme(
          displaySmall: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          labelLarge: TextStyle(
            color: kPrimaryColor,
          ),
          headlineSmall: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}
