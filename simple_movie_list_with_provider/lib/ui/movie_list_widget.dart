import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_movie_list_with_provider/model/movie.dart';
import 'package:simple_movie_list_with_provider/provider/movie_provider.dart';

class MovieListWidget extends StatelessWidget {
  MovieListWidget({Key? key}) : super(key: key);

  late MovieProvider _movieProvider;

  Widget _makeListView(List<Movie> movies) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return Center(
            child: Text(movies[index].originalTitle),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            thickness: 1,
          );
        },
        itemCount: movies.length);
  }

  @override
  Widget build(BuildContext context) {
    // listen을 true로 할경우 무한루프 발생한다
    // _movieProvider 등록 -> listen true 이기 때문에 데이터 변경시 리빌드를 한다
    // _movieProvider.loadMovies()는 notifyListener()를 발생시키며 데이터를 변경한다.
    // 등록한 프로바이더의 데이터가 변경되었으므로 리빌드가 된다
    // loadMovies() 재호출...
    // 무한반복...
    _movieProvider = Provider.of<MovieProvider>(context, listen: false);
    _movieProvider.loadMovies();

    return Scaffold(
      appBar: AppBar(title: Text("Movie Provider")),
      body: Consumer<MovieProvider>(
        builder: (context, provider, widget) {
          // 되도록 조건문은 간결하게
          // 어차피 if 조건에서 return을 하면 이후 시나리오는 없으므로
          // else보다 아래처럼 if 블록 아래에 처리하는게 좋다.

          // 현재같은 경우 오직 data가 있는지 아닌지만 알 수 있다
          // state를 두거나 하여 좀더 다양한 처리를 하면 좋다.
          if (provider.movies.isNotEmpty) {
            return _makeListView(provider.movies);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
