import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HouseOfMPage extends StatelessWidget {
  const HouseOfMPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 자동으로 leading에 drawer, back 버튼을 생성하는 옵션
        automaticallyImplyLeading: true,
        title: const Text("Houst Of M"),
      ),
      body: Center(
        child: OutlinedButton(
          onPressed: () => context.go("/all_new_all_different"),
          child: Text("도라간다!"),
        ),
      ),
    );
  }
}
