import 'package:carrot_market/page/detail_content_view.dart';
import 'package:carrot_market/repository/contents_repository.dart';
import 'package:carrot_market/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavoriteContents extends StatefulWidget {
  const FavoriteContents({Key? key}) : super(key: key);

  @override
  State<FavoriteContents> createState() => _FavoriteContentsState();
}

class _FavoriteContentsState extends State<FavoriteContents> {
  late ContentsRepository _contentsRepository;

  @override
  void initState() {
    super.initState();
    _contentsRepository = ContentsRepository();
  }

  _appBarWidget() {
    return AppBar(
      title: const Text(
        "관심목록",
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  _loadFavoriteContentsList() {
    return _contentsRepository.loadFavoriteContent();
  }

  Widget _makeDataList(datas) {
    return ListView.separated(
        // ListView의 전체 이므로 옆의 간격을 통합해서 띄우기 쉽다
        // itemBuilder에서 간격을 주면 seperaorBuilder에서 또 따로 간격을 줘야하는 번거로움과 복잡함이 있다.
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // TODO 이거 말고 다른 방법 없나?
              // Object? -> Map<String, String>
              Map<dynamic, dynamic> data = datas[index];
              Map<String, String> convertedData =
                  Map<String, String>.from(data);
              Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          DetailContentView(data: convertedData)));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    // scale을 주거나 width height로 고정
                    child: Hero(
                      //TODO 요거 나중에 프로바이더로 공유 가능한지?
                      tag: datas![index]["cid"]!,
                      child: Image.asset(
                        datas![index]["image"]!,
                        width: 100,
                      ),
                    ),
                  ),
                  // 여기서도 Expanded를 해줘야 ClipRRect를 써서 남은 부분을 전부 가져갈 수 있음
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            datas[index]["title"]!,
                            style: const TextStyle(fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            datas[index]["location"]!,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                                overflow: TextOverflow.ellipsis),
                          ),
                          Text(
                            DataUtils.calcStringToWon(datas[index]["price"]!),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                overflow: TextOverflow.ellipsis),
                          ),
                          // Column의 사이즈는 무한, Container 또한 사이즈 지정 없으면 고정된 값이 없음
                          // 상위 위젯이 고정된 사이즈를 가져야 오류가 없다
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SvgPicture.asset(
                                  "assets/svg/heart_off.svg",
                                  width: 13,
                                  height: 13,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(datas[index]["likes"]!),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.black.withOpacity(0.5),
            thickness: 0.5,
          );
        },
        itemCount: datas!.length);
  }

  _bodyWidget() {
    return FutureBuilder(
      future: _loadFavoriteContentsList(),
      builder: (context, snapshot) {
        // Future가 끝나지 않으면 여기로 처리됨
        if (snapshot.connectionState != ConnectionState.done) {
          // primarySwatch가 white라서 로딩이 안나옴
          return const Center(
            child: CircularProgressIndicator(color: Colors.blue),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text("데이터 오류"),
          );
        }

        if (snapshot.hasData) {
          // hasData 조건이 data != null이기 때문에 null로 오게 해야함
          // Empty List로 오면 형변환 실패가 발생한다!
          // 애당초 hasData가 true여야 data가 의미가 있으므로 여기서 처리하는게 좋다고 생각
          List<dynamic>? datas = snapshot.data as List<dynamic>?;
          return _makeDataList(datas);
        }

        return Center(
          child: Text("데이터 업성"),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
      body: _bodyWidget(),
    );
  }
}
