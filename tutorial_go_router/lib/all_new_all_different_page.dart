import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AllNewAllDifferentPage extends StatelessWidget {
  const AllNewAllDifferentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 자동으로 leading에 drawer, back 버튼을 생성하는 옵션
        automaticallyImplyLeading: true,
        title: const Text("All New All Different"),
      ),
      body: Center(
        child: Column(
          children: [
            OutlinedButton(
              onPressed: () => context.go("/"),
              child: Text("도라간다!"),
            ),
            OutlinedButton(
              onPressed: () => context.go("/settings/man_from_earth"),
              child: Text("수평이동"),
            ),
            OutlinedButton(
              onPressed: () => context.go("/all_new_all_different/house_of_m"),
              child: Text("더 드러간다!"),
            ),
          ],
        ),
      ),
    );
  }
}
