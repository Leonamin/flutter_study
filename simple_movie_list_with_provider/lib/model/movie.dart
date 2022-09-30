class Movie {
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;

  Movie({
    required this.overview,
    required this.posterPath,
    required this.originalTitle,
    required this.popularity,
  });

  /*
  factory 패턴
  싱글톤 패턴을 아주 간단하게 만들어주는 dart의 기법
  */

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        overview: json["overview"] as String,
        posterPath: json["poster_path"] as String,
        originalTitle: json["original_title"] as String,
        popularity: json["popularity"] as double);
  }
}
