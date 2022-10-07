import 'package:flutter/widgets.dart';
import 'package:simple_movie_list_with_provider/model/movie.dart';
import 'package:simple_movie_list_with_provider/model/movie_detail.dart';
import 'package:simple_movie_list_with_provider/repository/movie_repository.dart';

class MovieProvider extends ChangeNotifier {
  MovieRepository _movieRepository = MovieRepository();
  List<MovieDetail> _movies = [];
  List<MovieDetail> get movies => _movies;

  /*
  provider

  repository에서 받은 데이터는 여기서 처리한다
  원칙적으로는 여기서 데이터 가공을 해야하며 데이터 가공이 복잡해지면 중간에 도메인 모델을 두면 되는것으로 알고 있다
  repository에서 받은 데이터를 예외처리하는 예시는 상태를 추가하거나 해서
  notLoaded, loading, loaded, empty, error 등으로 예외처리하는 시나리오를 생각해 볼 수 있다
  그리고 가공을 하여 되도록이면 UI에서 바로 대입만해서 쓸 수 있게 만들게 하자
  */

  loadMovies() async {
    List<Movie> listMovies = await _movieRepository.loadMovies();
    //listMovies 예외처리
    // 가공
    List<MovieDetail> _movieDetails = [];

    for (int i = 0; i < listMovies.length; i++) {
      _movieDetails.add(MovieDetail(
          overview: listMovies[i].overview,
          posterPath: listMovies[i].posterPath,
          originalTitle: listMovies[i].originalTitle,
          popularity: listMovies[i].popularity,
          cid: "$i"));
    }
    _movies = _movieDetails;
    notifyListeners();
  }
}
