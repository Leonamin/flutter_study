import 'package:carrot_market/page/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late int _currentPageIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentPageIndex = 0;
  }

  Widget _makeBody() {
    switch (_currentPageIndex) {
      case 0:
        return Home();
      case 1:
      case 2:
      case 3:
      case 4:
      default:
        return Container();
    }
  }

  BottomNavigationBarItem _makeBottomNavigationBarItem(
      String iconName, String label) {
    return BottomNavigationBarItem(
        icon: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SvgPicture.asset(
            "assets/svg/${iconName}_off.svg",
            width: 22,
          ),
        ),
        activeIcon: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SvgPicture.asset(
            "assets/svg/${iconName}_on.svg",
            width: 22,
          ),
        ),
        label: label);
  }

  Widget _makeBottomNavigator() {
    return BottomNavigationBar(
        // 애니메이션
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          print(index);
          setState(() {
            _currentPageIndex = index;
          });
        },
        currentIndex: _currentPageIndex,
        selectedItemColor: Colors.black,
        selectedFontSize: 12,
        unselectedItemColor: Colors.black38,
        items: [
          // label 안넣으면 오류남
          _makeBottomNavigationBarItem("home", "홈"),
          _makeBottomNavigationBarItem("notes", "동네 생활"),
          _makeBottomNavigationBarItem("location", "내 근처"),
          _makeBottomNavigationBarItem("chat", "채팅"),
          _makeBottomNavigationBarItem("user", "나의 당근"),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _makeBody(),
      bottomNavigationBar: _makeBottomNavigator(),
    );
  }
}
