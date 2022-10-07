import 'package:simple_movie_list_with_provider/model/movie.dart';

class MovieDetail extends Movie {
  String cid;
  MovieDetail(
      {required super.overview,
      required super.posterPath,
      required super.originalTitle,
      required super.popularity,
      required this.cid});
}
