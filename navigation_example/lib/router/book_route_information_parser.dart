import 'package:flutter/material.dart';
import 'package:navigation_example/models/book_route_path.dart';

/// RouteInformationParser는 RouteInformation을 가져와서 파싱할 수 있게 해준다.
/// 그리고 가져온 데이터를 유저가 정의한 BookRoutePath로 바꿔준다.
/// 즉 RouteInformation -> BookRoutePath로 바꿔주는 컨버터가 되는것이다.
///
/// 보니까 CuteShrew Client의 generateRoute에서 설정한거랑 별로 다를건 없어보인다.
class BookRouteInformationParser extends RouteInformationParser<BookRoutePath> {
  @override
  Future<BookRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    // Handle '/'
    if (uri.pathSegments.length == 0) {
      return BookRoutePath.home();
    }

    // Handle '/book/:id'
    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] != 'book') return BookRoutePath.unknown();
      var remaining = uri.pathSegments[1];
      var id = int.tryParse(remaining);
      if (id == null) return BookRoutePath.unknown();
      return BookRoutePath.details(id);
    }

    // Handle unknown routes
    return BookRoutePath.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(BookRoutePath path) {
    if (path.isUnknown) {
      return RouteInformation(location: '/404');
    }
    if (path.isHomePage) {
      return RouteInformation(location: '/');
    }
    if (path.isDetailsPage) {
      return RouteInformation(location: '/book/${path.id}');
    }
    return RouteInformation();
  }
}
