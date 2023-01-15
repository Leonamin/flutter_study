import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_go_router/login_notifier.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인 하시오!'),
      ),
      body: Center(
        child: OutlinedButton(
          child: Text(
            "로긴!",
          ),
          onPressed: () {
            context.read<LoginNotifier>().login('hamster');
          },
        ),
      ),
    );
  }
}
