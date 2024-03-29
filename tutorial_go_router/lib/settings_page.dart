import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  final String name;
  const SettingsPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 자동으로 leading에 drawer, back 버튼을 생성하는 옵션
        automaticallyImplyLeading: true,
        title: const Text("Settings!"),
      ),
      body: Center(
        child: Column(
          children: [
            OutlinedButton(
              onPressed: () => context.go("/"),
              child: Text("도라간다!"),
            ),
            OutlinedButton(
              onPressed: () => context.go("/all_new_all_different"),
              child: Text("수평이동"),
            ),
          ],
        ),
      ),
    );
  }
}
