import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_movie_list_with_provider/page_home.dart';
import 'package:simple_movie_list_with_provider/provider/bottom_navigation_provider.dart';
import 'package:simple_movie_list_with_provider/provider/movie_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (BuildContext context) => BottomNavigationProvider()),
          ChangeNotifierProvider(
              create: (BuildContext context) => MovieProvider()),
        ],
        child: HomePage(),
      ),
    );
  }
}
