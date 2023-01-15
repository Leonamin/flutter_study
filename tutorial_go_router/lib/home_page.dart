import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
              onPressed: () => context.go("/settings/cute"),
              child: Text("세팅으로 가자!"),
            ),
            OutlinedButton(
              onPressed: () => context.go("/all_new_all_different"),
              child: Text("새롭고 다른 으로가자!"),
            ),
          ],
        ),
      ),
    );
  }
}
