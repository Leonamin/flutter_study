import 'package:flutter/material.dart';
import 'package:navigation_example/screens/books_list_screen.dart';
import 'package:navigation_example/models/book_model.dart';
import 'package:navigation_example/pages/book_details_page.dart';
import 'package:navigation_example/screens/book_detail_screen.dart';
import 'package:navigation_example/screens/unknown_screen.dart';

class BooksApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BooksAppState();
}

/**
 * _BookAppState에서는 selected book과 book 리스트의 상태를 가지고 있다.
 * 그리고 _BookAppState()는 home에서 일반 위젯이 아닌 Page 객체 리스트를 가진 Navigator를 반환한다.
 */
class _BooksAppState extends State<BooksApp> {
  // New:
  Book? _selectedBook;
  bool show404 = false;
  List<Book> books = [
    Book('Left Hand of Darkness', 'Ursula K. Le Guin'),
    Book('Too Like the Lightning', 'Ada Palmer'),
    Book('Kindred', 'Octavia E. Butler'),
  ];

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Books App',
      /**
       * Navigator는 pages라는 새로운 인자를 얻었다. Page 리스트의 객체들이 바뀐다면 Navigator는 
       * 변경사항을 매치시키기 위해 route들의 스택을 업데이트 할 것이다. 
       */
      home: Navigator(
        // pages는 가장 마지막 페이지가 가장 첫번째로 온다.
        pages: [
          MaterialPage(
            key: ValueKey('BooksListPage'),
            child: BooksListScreen(
              books: books,
              // 여기서 _selectedBook을 바꿔서 상태가 바뀌면 아래의 BookDetailsPage 조건이 갖춰지고 상태가 바뀌면서 네비게이션이 진행된다.
              onTapped: _handleBookTapped,
            ),
          ),
          if (_selectedBook != null)
            // MaterialPage(
            //     key: ValueKey(_selectedBook),
            //     child: BookDetailsScreen(book: _selectedBook!))
            BookDetailsPage(book: _selectedBook!)
        ],
        // onPopPage: (route, result) => route.didPop(result),
        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            return false;
          }

          // Update the list of pages by setting _selectedBook to null
          setState(() {
            _selectedBook = null;
          });

          return true;
        },
      ),
    );
  }

  void _handleBookTapped(Book book) {
    setState(() {
      _selectedBook = book;
    });
  }
}
