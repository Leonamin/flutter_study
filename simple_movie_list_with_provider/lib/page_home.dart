import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_movie_list_with_provider/provider/bottom_navigation_provider.dart';
import 'package:simple_movie_list_with_provider/ui/home_widget.dart';
import 'package:simple_movie_list_with_provider/ui/movie_list_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  BottomNavigationProvider? _bottomNavigationProvider;

  /*
  UI

  UI와 관련된 동작만 할 수 있게 한다(아래 body switch case 처럼 UI 분기)
  데이터 처리는 provider에서 가져오기만 하며 데이터 호출만 존재해야한다
  BottomNavigation, SideMenu, TopNavigation 등등은 Provider에서 처리하면 매우 좋다
  Hover 등도 Provider에서 처리하는 방법이 있으니 나중에 해보자
  */

  Widget _navigationBody() {
    switch (_bottomNavigationProvider!.currentPage) {
      case 0:
        return HomeWidget();
      case 1:
        return MovieListWidget();
      default:
    }
    return Container();
  }

  Widget _bottomNavigationBar() {
    return Consumer(builder: ((context, value, child) {
      return BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Movie"),
        ],
        currentIndex: _bottomNavigationProvider!.currentPage,
        selectedItemColor: Colors.red,
        onTap: (index) {
          _bottomNavigationProvider!.updateCurrentPage(index);
        },
        //onHover:
        //Hover일 때 provider에 값을 저장하면 배경색을 바꾼다던지 그런 이벤트 처리 기법도 가능하다.
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    // listen을 false로 하면 _bottomNavigationProvider에 변화가 생겨도 업데이트가 안된다
    _bottomNavigationProvider = Provider.of<BottomNavigationProvider>(context);

    return Scaffold(
      body: _navigationBody(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }
}
