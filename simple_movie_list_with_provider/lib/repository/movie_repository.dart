import 'dart:convert';

import 'package:simple_movie_list_with_provider/model/movie.dart';
import 'package:http/http.dart' as http;

/*
Repository

데이터를 가져온다
데이터 가공은 하지 않는다.
Status Code에 따른 예외처리만 진행하여 데이터를 전달한다.
현재 예제는 간단하기 때문에 아래처럼 진행하였으나 복잡하게 바뀔경우 api도 분리한다
api -> repository -> provider 같이 진행된다.
api 는 response = tmdbApi.getMovies()) 이런식
response = imdb.getMovies()...
여러 API 서버를 이용할 수도 있으므로 분리를 한다.

*/
class MovieRepository {
  var queryParam = {
    'api_key': 'c6a7a85736754028e2a6fec6ff0b4943',
  };
  Future<List<Movie>> loadMovies() async {
    var uri = Uri.https('api.themoviedb.org', '/3/movie/popular', queryParam);
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      if (body["results"] != null) {
        List<dynamic> results = body["results"];
        return results.map<Movie>((item) => Movie.fromJson(item)).toList();
      }
    }
    return [];
  }
}
