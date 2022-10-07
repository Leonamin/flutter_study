import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class DetailContentView extends StatefulWidget {
  Map<String, String> data;
  DetailContentView({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailContentView> createState() => _DetailContentViewState();
}

class _DetailContentViewState extends State<DetailContentView> {
  late Size deviceSize;
  int _current = 0;
  final CarouselController _controller = CarouselController();
  late List<String> imgPathList;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // initState에서는 context 접근이 안되므로 여기서 가져온다
    deviceSize = MediaQuery.of(context).size;
    imgPathList = [
      widget.data["image"]!,
      widget.data["image"]!,
      widget.data["image"]!,
      widget.data["image"]!,
      widget.data["image"]!,
    ];
  }

  // return Type이 Widget이면 PreferredSizeWidget이 필요하다고 나옴
  AppBar _makeAppBarWidget() {
    return AppBar(
      // 투명 처리
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          )),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
              color: Colors.white,
            )),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            )),
      ],
    );
  }

  Widget _makeBody() {
    return Container(
        child: Stack(
      children: [
        Hero(
          tag: widget.data['cid']!,
          child: CarouselSlider(
            items: imgPathList.map((url) {
              return Image.asset(
                url,
                width: deviceSize.width,
                fit: BoxFit.fill,
              );
            }).toList(),
            carouselController: _controller,
            options: CarouselOptions(
                height: deviceSize.width,
                initialPage: 0,
                enableInfiniteScroll: false, //무한 스크롤
                viewportFraction: 1, //화면 차지하는 비율 1이면 전체 0.8이면 80퍼센트
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Positioned(
          bottom: 0,
          // left, right를 0으로 하면 가로 부분 전체 영역을 차지할 수 있다 top도 0으로 하면 높이 부분을 전체로 차지한다
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgPathList.asMap().entries.map((entry) {
              // 강의에서는 해당 부분이 이전 버전 예제라서 인덱스 오류가 있었는데 4.x 버전은 없다
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 10.0,
                  height: 10.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 5.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.white.withOpacity(0.5))
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
        )
      ],
    ));
  }

  Widget _makeBottomBarWidget() {
    return Container(
      width: deviceSize.width,
      height: 55,
      color: Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 이거 true로 주면 앱바 겹치는 효과 발생
      extendBodyBehindAppBar: true,
      appBar: _makeAppBarWidget(),
      body: _makeBody(),
      bottomNavigationBar: _makeBottomBarWidget(),
    );
  }
}
