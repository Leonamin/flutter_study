import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_authentication/src/pages/login_widget.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  AppBar _appBarWidget() {
    return AppBar(
      title: const Text("파이어베이스 SNS 로그인"),
    );
  }

  Widget _bodyWidget() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> sanpshot) {
          if (!sanpshot.hasData) {
            return LoginWidget();
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("HELLO ${sanpshot.data!.displayName}"),
                  TextButton(
                    onPressed: FirebaseAuth.instance.signOut,
                    child: Text("로그아웃"),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.grey.withOpacity(0.3))),
                  )
                ],
              ),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _appBarWidget(),
      body: _bodyWidget(),
    );
  }
}
