import 'package:carousel_slider/carousel_slider.dart';
import 'package:carrot_market/components/manor_temperature_widget.dart';
import 'package:carrot_market/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailContentView extends StatefulWidget {
  Map<String, String> data;
  DetailContentView({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailContentView> createState() => _DetailContentViewState();
}

class _DetailContentViewState extends State<DetailContentView>
    with SingleTickerProviderStateMixin {
  late Size deviceSize;
  int _current = 0;
  final CarouselController _controller = CarouselController();
  late List<String> imgPathList;

  // 기능 좋아요 변수
  bool _subscribeSelectedState = false;
  bool _subscribeHoveringState = false;

  // 기능 앱바 스크롤 색상전환 변수
  double scrollPostionToAlpha = 0;
  final ScrollController _bodyScrollController = ScrollController();
  late AnimationController _animationController;
  late Animation _colorTween;

  @override
  void initState() {
    super.initState();

    //기능 앱바 스크롤 색상전환 애니메이션 등록
    _animationController = AnimationController(vsync: this);
    _colorTween = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_animationController);
    //기능 앱바 스크롤 색상전환 리스너 등록
    _bodyScrollController.addListener(() {
      setState(() {
        if (_bodyScrollController.offset > 255) {
          scrollPostionToAlpha = 255;
        } else {
          scrollPostionToAlpha = _bodyScrollController.offset;
        }
        _animationController.value = scrollPostionToAlpha / 255;
      });
    });
  }

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

  //기능 앱바 스크롤 색상 전환 아이콘 버튼 색변환 애니메이션 적용
  Widget _makeAnimatedIcon(IconData iconData) {
    return AnimatedBuilder(
        animation: _colorTween,
        builder: (context, child) => Icon(
              iconData,
              color: _colorTween.value,
            ));
  }

  // return Type이 Widget이면 PreferredSizeWidget이 필요하다고 나옴
  AppBar _makeAppBarWidget() {
    return AppBar(
      // 기능 앱바 스크롤 색상전환 배경색 변환 적용
      backgroundColor: Colors.white.withAlpha(scrollPostionToAlpha.toInt()),
      elevation: 0,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: _makeAnimatedIcon(Icons.arrow_back)),
      actions: [
        IconButton(onPressed: () {}, icon: _makeAnimatedIcon(Icons.share)),
        IconButton(onPressed: () {}, icon: _makeAnimatedIcon(Icons.more_vert)),
      ],
    );
  }

  Widget _makeSliderImage() {
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

  Widget _sellerSimpleInfo() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: Image.asset(
              "assets/images/user.png",
            ).image,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "양",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                "컨테이너",
              )
            ],
          ),
          // 요렇게 줘도 옆으로 몰리고 아래 매너 온도 위젯을 Expanded로 감싸서 CrossExisAlignment.end로 해도 된다
          Expanded(child: Container()),
          ManorTemperatureWidget(manorTemp: 37.5)
        ],
      ),
    );
  }

  Widget _line() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      height: 1,
      color: Colors.grey.withOpacity(0.3),
    );
  }

  Widget _contentDetail() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          widget.data["title"]!,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          "분류 * 시간",
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          "내용",
          style: const TextStyle(height: 1.5, fontSize: 15),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          "채팅 관심 조회",
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        const SizedBox(
          height: 15,
        ),
      ]),
    );
  }

  Widget _makeOtherCellContents() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "판매자님의 판매 상품",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Text(
            "모두 보기",
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _cellContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 120,
            color: Colors.grey,
            // child: Image.asset(
            //   "assets/images/user.png",)
          ),
        ),
        Text(
          "상품",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Text(
          "가격",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ],
    );
  }

  Widget _makeBody() {
    // return SingleChildScrollView(
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       _makeSliderImage(),
    //       _sellerSimpleInfo(),
    //       _line(),
    //       _contentDetail(),
    //       _line(),
    //       _makeOtherCellContents(),
    //     ],
    //   ),
    // );
    return CustomScrollView(
      // 기능 앱바 스크롤 색상전환 컨트롤러 설정
      controller: _bodyScrollController,
      slivers: [
        SliverList(
            delegate: SliverChildListDelegate([
          _makeSliderImage(),
          _sellerSimpleInfo(),
          _line(),
          _contentDetail(),
          _line(),
          _makeOtherCellContents(),
        ])),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
            delegate: SliverChildListDelegate(List.generate(20, (index) {
              return _cellContent();
            }).toList()),
          ),
        ),
      ],
    );
  }

  Widget _makeBottomBarWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: deviceSize.width,
      height: 55,
      child: Row(
        children: [
          InkWell(
            // 나름 구독 상태 확인 만든거
            // 문제점
            // 1. 서버상태를 불러오는거는 뭐 알아서
            // 2. 탭, 호버 상태 관리를 위해 변수 2개나 쓴다!
            onTap: () {
              setState(() {
                _subscribeSelectedState = !_subscribeSelectedState;
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text(_subscribeSelectedState ? "관심 목록 추가" : "관심 목록 삭제"),
                duration: const Duration(milliseconds: 1000),
              ));
            },
            onHover: (value) {
              setState(() {
                _subscribeHoveringState = value;
              });
            },
            child: SvgPicture.asset(
              _subscribeSelectedState ^ _subscribeHoveringState
                  ? "assets/svg/heart_on.svg"
                  : "assets/svg/heart_off.svg",
              width: 20,
              height: 20,
              color: const Color(0xFFF08F4F),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            width: 1,
            height: 40,
            color: Colors.grey.withOpacity(0.3),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DataUtils.calcStringToWon(widget.data["price"]!),
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Text(
                "가격 제안",
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          Expanded(
              // 여기를 Row로 감싸면 내부 위젯 크기만큼만 사용한다.
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                // color: const Color(0xFFF08F4F), decoration 사용시 color는 decoration에 사용
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xFFF08F4F)),
                child: const Text(
                  "채팅으로 거래하기",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ))
        ],
      ),
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
