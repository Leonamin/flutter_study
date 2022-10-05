class ContentsRepository {
  Map<String, dynamic> data = {
    "little_china": [
      {
        "cid": "1",
        "image": "assets/images/ara-1.jpg",
        "title": "네메시스 축구화275",
        "location": "나이트시티 리틀 차이나",
        "price": "30000",
        "likes": "2"
      },
      {
        "cid": "2",
        "image": "assets/images/ara-2.jpg",
        "title": "LA갈비 5kg팔아요~",
        "location": "나이트시티 리틀 차이나",
        "price": "100000",
        "likes": "5"
      },
      {
        "cid": "3",
        "image": "assets/images/ara-3.jpg",
        "title": "치약팝니다",
        "location": "나이트시티 리틀 차이나",
        "price": "5000",
        "likes": "0"
      },
      {
        "cid": "4",
        "image": "assets/images/ara-4.jpg",
        "title": "[풀박스]맥북프로16인치 터치바 스페이스그레이",
        "location": "나이트시티 리틀 차이나",
        "price": "2500000",
        "likes": "6"
      },
      {
        "cid": "5",
        "image": "assets/images/ara-5.jpg",
        "title": "디월트존기임팩",
        "location": "나이트시티 리틀 차이나",
        "price": "150000",
        "likes": "2"
      },
      {
        "cid": "6",
        "image": "assets/images/ara-6.jpg",
        "title": "갤럭시s10",
        "location": "나이트시티 리틀 차이나",
        "price": "180000",
        "likes": "2"
      },
      {
        "cid": "7",
        "image": "assets/images/ara-7.jpg",
        "title": "선반",
        "location": "나이트시티 리틀 차이나",
        "price": "15000",
        "likes": "2"
      },
      {
        "cid": "8",
        "image": "assets/images/ara-8.jpg",
        "title": "냉장 쇼케이스",
        "location": "나이트시티 리틀 차이나",
        "price": "80000",
        "likes": "3"
      },
      {
        "cid": "9",
        "image": "assets/images/ara-9.jpg",
        "title": "대우 미니냉장고",
        "location": "나이트시티 리틀 차이나",
        "price": "30000",
        "likes": "3"
      },
      {
        "cid": "10",
        "image": "assets/images/ara-10.jpg",
        "title": "멜킨스 풀업 턱걸이 판매합니다.",
        "location": "나이트시티 리틀 차이나",
        "price": "50000",
        "likes": "7"
      }
    ],
    "kabuki": [
      {
        "cid": "1",
        "image": "assets/images/ora-1.jpg",
        "title": "네메시스 축구화275",
        "location": "나이트시티 리틀 차이나",
        "price": "30000",
        "likes": "2"
      },
      {
        "cid": "2",
        "image": "assets/images/ora-2.jpg",
        "title": "LA갈비 5kg팔아요~",
        "location": "나이트시티 리틀 차이나",
        "price": "100000",
        "likes": "5"
      },
      {
        "cid": "3",
        "image": "assets/images/ora-3.jpg",
        "title": "치약팝니다",
        "location": "나이트시티 리틀 차이나",
        "price": "5000",
        "likes": "0"
      },
      {
        "cid": "4",
        "image": "assets/images/ora-4.jpg",
        "title": "[풀박스]맥북프로16인치 터치바 스페이스그레이",
        "location": "나이트시티 리틀 차이나",
        "price": "2500000",
        "likes": "6"
      },
      {
        "cid": "5",
        "image": "assets/images/ora-5.jpg",
        "title": "디월트존기임팩",
        "location": "나이트시티 리틀 차이나",
        "price": "150000",
        "likes": "2"
      },
      {
        "cid": "6",
        "image": "assets/images/ora-6.jpg",
        "title": "갤럭시s10",
        "location": "나이트시티 리틀 차이나",
        "price": "180000",
        "likes": "2"
      },
      {
        "cid": "7",
        "image": "assets/images/ora-7.jpg",
        "title": "선반",
        "location": "나이트시티 리틀 차이나",
        "price": "15000",
        "likes": "2"
      },
      {
        "cid": "8",
        "image": "assets/images/ora-8.jpg",
        "title": "냉장 쇼케이스",
        "location": "나이트시티 리틀 차이나",
        "price": "80000",
        "likes": "3"
      },
      {
        "cid": "9",
        "image": "assets/images/ora-9.jpg",
        "title": "대우 미니냉장고",
        "location": "나이트시티 리틀 차이나",
        "price": "30000",
        "likes": "3"
      },
      {
        "cid": "10",
        "image": "assets/images/ora-10.jpg",
        "title": "멜킨스 풀업 턱걸이 판매합니다.",
        "location": "나이트시티 리틀 차이나",
        "price": "50000",
        "likes": "7"
      }
    ],
    "north_side": null
  };

  // 이거를 dynamic으로 안하고 하는법은?
  // Future<List<Map<String, String>>>? loadContentsFromLocation(
  Future<dynamic>? loadContentsFromLocation(String location) async {
    //API 통신 location값을 보내준다
    await Future.delayed(Duration(seconds: 1));
    return data[location];
  }
}
