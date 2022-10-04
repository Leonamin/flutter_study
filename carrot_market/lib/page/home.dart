import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Map<String, String>> datas;
  late int _currentPageIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentPageIndex = 0;
    datas = [
      {
        "cid": "1",
        "image": "assets/images/ara-1.jpg",
        "title": "네메시스 축구화275",
        "location": "제주 제주시 아라동",
        "price": "30000",
        "likes": "2"
      },
      {
        "cid": "2",
        "image": "assets/images/ara-2.jpg",
        "title": "LA갈비 5kg팔아요~",
        "location": "제주 제주시 아라동",
        "price": "100000",
        "likes": "5"
      },
      {
        "cid": "3",
        "image": "assets/images/ara-3.jpg",
        "title": "치약팝니다",
        "location": "제주 제주시 아라동",
        "price": "5000",
        "likes": "0"
      },
      {
        "cid": "4",
        "image": "assets/images/ara-4.jpg",
        "title": "[풀박스]맥북프로16인치 터치바 스페이스그레이",
        "location": "제주 제주시 아라동",
        "price": "2500000",
        "likes": "6"
      },
      {
        "cid": "5",
        "image": "assets/images/ara-5.jpg",
        "title": "디월트존기임팩",
        "location": "제주 제주시 아라동",
        "price": "150000",
        "likes": "2"
      },
      {
        "cid": "6",
        "image": "assets/images/ara-6.jpg",
        "title": "갤럭시s10",
        "location": "제주 제주시 아라동",
        "price": "180000",
        "likes": "2"
      },
      {
        "cid": "7",
        "image": "assets/images/ara-7.jpg",
        "title": "선반",
        "location": "제주 제주시 아라동",
        "price": "15000",
        "likes": "2"
      },
      {
        "cid": "8",
        "image": "assets/images/ara-8.jpg",
        "title": "냉장 쇼케이스",
        "location": "제주 제주시 아라동",
        "price": "80000",
        "likes": "3"
      },
      {
        "cid": "9",
        "image": "assets/images/ara-9.jpg",
        "title": "대우 미니냉장고",
        "location": "제주 제주시 아라동",
        "price": "30000",
        "likes": "3"
      },
      {
        "cid": "10",
        "image": "assets/images/ara-10.jpg",
        "title": "멜킨스 풀업 턱걸이 판매합니다.",
        "location": "제주 제주시 아라동",
        "price": "50000",
        "likes": "7"
      },
    ];
  }

  AppBar _makeAppBar() {
    return AppBar(
      // Inkwell은 그림자 배경으로 클릭시 효과 발생
      title: InkWell(
        onTap: () {
          print("C");
        },
        child: Row(
          children: const [
            Text(
              '아라동',
              style: TextStyle(color: Colors.black),
            ),
            Icon(
              Icons.arrow_drop_down,
            )
          ],
        ),
      ),
      // 그림자 생성 1로 하면 그림자 최저로 줄어듦(없어짐)
      elevation: 1,
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            )),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.tune,
              color: Colors.black,
            )),
        IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/svg/bell.svg",
              width: 22.0,
              color: Colors.black,
            )),
      ],
    );
  }

  final oCcy = NumberFormat("#,###", "ko_KR");
  String calcStringToWon(String priceString) {
    return "${oCcy.format(int.parse(priceString))}원";
  }

  Widget _makeBody() {
    return ListView.separated(
        // ListView의 전체 이므로 옆의 간격을 통합해서 띄우기 쉽다
        // itemBuilder에서 간격을 주면 seperaorBuilder에서 또 따로 간격을 줘야하는 번거로움과 복잡함이 있다.
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  // scale을 주거나 width height로 고정
                  child: Image.asset(
                    datas[index]["image"]!,
                    width: 100,
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
                          calcStringToWon(datas[index]["price"]!),
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
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.black.withOpacity(0.5),
            thickness: 0.5,
          );
        },
        itemCount: datas.length);
  }

  BottomNavigationBarItem _makeBottomNavigationBarItem(
      String iconName, String label) {
    return BottomNavigationBarItem(
        icon: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SvgPicture.asset(
            "assets/svg/${iconName}_off.svg",
            width: 22,
          ),
        ),
        label: label);
  }

  Widget _makeBottomNavigator() {
    return BottomNavigationBar(
        // 애니메이션
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        currentIndex: _currentPageIndex,
        selectedItemColor: Colors.black,
        selectedFontSize: 12,
        unselectedItemColor: Colors.black38,
        items: [
          // label 안넣으면 오류남
          _makeBottomNavigationBarItem("home", "홈"),
          _makeBottomNavigationBarItem("notes", "동네 생활"),
          _makeBottomNavigationBarItem("location", "내 근처"),
          _makeBottomNavigationBarItem("chat", "채팅"),
          _makeBottomNavigationBarItem("user", "나의 당근"),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _makeAppBar(),
      body: _makeBody(),
      bottomNavigationBar: _makeBottomNavigator(),
    );
  }
}
