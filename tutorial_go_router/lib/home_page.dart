import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_go_router/login_notifier.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home!"),
      ),
      body: Center(
        child: Column(
          children: [
            OutlinedButton(
              onPressed: () => context.goNamed("settings", params: {
                "name": "cute"
              }, queryParams: {
                "email": "example@gmail.com",
                "age": "25",
                "place": "India"
              }),
              child: Text("세팅으로 가자!"),
            ),
            OutlinedButton(
              onPressed: () => context.go("/all_new_all_different"),
              child: Text("새롭고 다른 으로가자!"),
            ),
            OutlinedButton(
              onPressed: () => context.read<LoginNotifier>().logout(),
              child: Text("록 아웃!"),
            ),
          ],
        ),
      ),
    );
  }
}
