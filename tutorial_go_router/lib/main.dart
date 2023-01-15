import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tutorial_go_router/home_page.dart';
import 'package:tutorial_go_router/settings_page.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    path: '/settings',
    builder: (context, state) => const SettingsPage(),
  ),
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'GOGO ROUTER',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
    );
  }
}
