import 'package:carrot_market/page/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const MaterialColor primaryWhite = MaterialColor(
  _whitePrimaryValue,
  <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(_whitePrimaryValue),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  },
);
const int _whitePrimaryValue = 0xFFFFFFFF;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // primarySwatch로 사용할 수 있는 색상은 Colors에서 MaterialColor 타입으로 지정되어 있는 색만 사용 가능하다
        // 그리고 일반적으로 blue, grey, black 등 범위를 가진 견본 타입들이 MaterialColor 타입이다.
        // https://stackoverflow.com/questions/50212484/what-is-the-difference-between-primarycolor-and-primaryswatch-in-flutter
        // white를 쓰고 싶으면 커스텀으로 white를 추가해야하는데 귀찮으니 그냥 한다.
        primarySwatch: primaryWhite,
      ),
      home: const Home(),
    );
  }
}
