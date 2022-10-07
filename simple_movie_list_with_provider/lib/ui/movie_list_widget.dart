import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_movie_list_with_provider/detail_content_view.dart';
import 'package:simple_movie_list_with_provider/model/movie.dart';
import 'package:simple_movie_list_with_provider/model/movie_detail.dart';
import 'package:simple_movie_list_with_provider/provider/movie_provider.dart';

class MovieListWidget extends StatelessWidget {
  MovieListWidget({Key? key}) : super(key: key);

  late MovieProvider _movieProvider;

  Widget _makeMovieOne(MovieDetail movie) {
    return Row(
      children: [
        // ClipRRect 이걸 왜해주나요
        // makeListView에서 Container에서 BoxDecoration으로 둥글게 만들어도 실제영역이 줄어든게 아니라 그렇게 보이는거기 때문
        // 포스터의 보이는 영역도 줄여줘야 좌우가 똑같아진다
        ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
            child: Hero(tag: movie.cid, child: Image.network(movie.posterUrl))),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                movie.originalTitle,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Text(
                  movie.overview,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 8,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13),
                ),
              )
            ],
          ),
        ))
      ],
    );
  }

  Widget _makeListView(List<MovieDetail> movies) {
    return ListView.separated(
        itemBuilder: (context, index) {
          // return Center(
          //   child: Text(movies[index].originalTitle),
          // );
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return DetailContentView(data: movies[index]);
                },
              ));
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 200,
                //Container에 Colors 넣으면 에러
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset: const Offset(0, 0),
                      )
                    ]),
                child: _makeMovieOne(movies[index]),
              ),
            ),
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
