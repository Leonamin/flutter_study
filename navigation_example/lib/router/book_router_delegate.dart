import 'package:flutter/material.dart';
import 'package:navigation_example/models/book_model.dart';
import 'package:navigation_example/models/book_route_path.dart';
import 'package:navigation_example/pages/book_details_page.dart';
import 'package:navigation_example/screens/books_list_screen.dart';
import 'package:navigation_example/screens/unknown_screen.dart';

//RouterDelegate<BookRoutePath> 이 부분이 T를 사용자가 정의한 데이터 타입을 말한다.
// 그리고 StatefulWidget에서 ChangeNotifier로 바뀌었으므로 변수의 상태 변경을 나타내기 위해
// setState()가 아니라 notifyListeners()를 사용한다.
// RouterDelegate가 리스터를 호출하면 Router 위젯 또한 마찬가지로 RouterDelegate의 currentConfiguration이 바뀌었다고 알려준다
// build 메소드는 새로운 Navigator를 빌드하기 위해 다시 호출된다.
// RouterDelegate에서 notifyListeners() 발생 -> Router는 변경을 인지하고 RouterDelegate의 currentConfiguration 호출
// 그리고 build 메소드 호출해서 Navigator를 다시 빌드한다.

class BookRouterDelegate extends RouterDelegate<BookRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
  final GlobalKey<NavigatorState> _navigatorKey;

  Book? _selectedBook;
  bool show404 = false;

  List<Book> books = [
    Book('Left Hand of Darkness', 'Ursula K. Le Guin'),
    Book('Too Like the Lightning', 'Ada Palmer'),
    Book('Kindred', 'Octavia E. Butler'),
  ];

  BookRouterDelegate() : _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    // TODO
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: ValueKey('BooksListPage'),
          child: BooksListScreen(
            books: books,
            onTapped: _handleBookTapped,
          ),
        ),
        if (show404)
          MaterialPage(key: ValueKey('UnknownPage'), child: UnknownScreen())
        else if (_selectedBook != null)
          BookDetailsPage(book: _selectedBook!)
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        // Update the list of pages by setting _selectedBook to null
        _selectedBook = null;
        show404 = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  // TODO
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  // 새로운 Route가 어플리케이션에 push되면 Router는 setNewRoutePath를 호출하고
  // setNewRoutePath는 앱의 경로의 변경 사항을 기반으로 앱 상태를 업데이트 할 수 있게한다.
  @override
  Future<void> setNewRoutePath(BookRoutePath configuration) async {
    print(configuration.toString());
    if (configuration.isUnknown) {
      _selectedBook = null;
      show404 = true;
      return;
    }

    if (configuration.isDetailsPage) {
      if (configuration.id! < 0 || configuration.id! > books.length - 1) {
        show404 = true;
        return;
      }

      _selectedBook = books[configuration.id!];
    } else {
      _selectedBook = null;
    }

    show404 = false;
  }

  @override
  BookRoutePath get currentConfiguration {
    if (show404) {
      return BookRoutePath.unknown();
    }

    return _selectedBook == null
        ? BookRoutePath.home()
        : BookRoutePath.details(books.indexOf(_selectedBook!));
  }

  void _handleBookTapped(Book book) {
    _selectedBook = book;
    notifyListeners();
  }
}
