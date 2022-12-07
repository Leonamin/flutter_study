import 'package:dribble_1/widgets/emotion_face.dart';
import 'package:dribble_1/widgets/round_top_containter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '')
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  // 환영인사 표시
                  _makeGreeting(),
                  const SizedBox(
                    height: 20,
                  ),
                  _makeSearchBar(),
                  const SizedBox(
                    height: 25,
                  ),
                  _makeAskFeeling(),
                  const SizedBox(
                    height: 25,
                  ),
                  _makeFeelingCards(),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(child: _makeBody()),
          ],
        ),
      ),
    );
  }

  Row _makeFeelingCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            EmotionFace(
              icon: '🙁',
              size: 30,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '나쁨',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
        Column(
          children: [
            EmotionFace(
              icon: '😐',
              size: 30,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '괜찮음',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
        Column(
          children: [
            EmotionFace(
              icon: '😄',
              size: 30,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '좋음',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
        Column(
          children: [
            EmotionFace(
              icon: '😁',
              size: 30,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '다이스키',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ],
    );
  }

  Row _makeAskFeeling() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '기분이 어떠세요?',
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Icon(
          Icons.more_horiz,
          color: Colors.white,
        ),
      ],
    );
  }

  Row _makeGreeting() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // User
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '환영합니다 KIM',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              '2022년 12월 25일',
              style: TextStyle(color: Colors.blue[100]),
            )
          ],
        ),

        // Notification
        Container(
          decoration: BoxDecoration(
              color: Colors.blue[600], borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.all(12),
          child: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  _makeSearchBar() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue[600], borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: Colors.white,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            '검색',
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  _makeBody() {
    return RoundTopContainer(
      padding: const EdgeInsets.all(25),
      color: Colors.white,
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '활동',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                ),
                Icon(Icons.more_horiz),
              ],
            )
          ],
        ),
      ),
    );
  }
}
