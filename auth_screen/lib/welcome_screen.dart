import 'package:auth_screen/constants.dart';
import 'package:auth_screen/siginin_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage("assets/dotg.jpg"))),
              )),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /*
              Flutter 쓰면서 오늘 처음 제대로 읽어 봤는데
              RichText는 다른 TextStyle을 가진 문자들을 모아서 쓸 수 있는 것이고
              TextSpan을 사용한다.
              TextSpan은 단위 문자열로 사용하여 아래처럼 여러개의 위젯을 한 문단으로 구성할 수 있다.
              */
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                    text: "SHREW\n",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  TextSpan(
                    text: "The cutest animal in the world",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ]),
              ),
              FittedBox(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SiginInScreen(),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 28),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 26, vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: kPrimaryColor,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "FIND MORE CUTES.",
                          // copyWith()
                          // 이미 만들어진 TextStyle을 복사하고 인자로 넣은 새로운 값은 대체한다.
                          // 일부분만 바꾸고 싶을 때 사용한다.
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
