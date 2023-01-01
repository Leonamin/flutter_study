import 'package:clock_app_tutorial/config/constants/theme_data.dart';
import 'package:clock_app_tutorial/config/data.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AlarmPage extends StatelessWidget {
  const AlarmPage({super.key});

  static const double cardRadius = 24;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Alarm',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Expanded(
            child: ListView(
              children: alarms.map<Widget>((alarm) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 32),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: alarm.gradientColor,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(cardRadius),
                    ),
                    boxShadow: [
                      /**
                       * color: 불투명할 수록 그림자도 옅어진다 
                       * blurRadius: 그림자 둥근거 borderRadius 값을 더해서 굴곡처리가 된다.(직각일 때 이거조차 0이면 직각이 된다.)
                       * spreadRadius: 말그래도 뿌려지는 범위
                       * offset: 블러 처리가 위젯 어디서부터 할 건지 0,0이면 골고루 x, y 바꿀수록 가로 세로 표현이 바뀐다.
                       */
                      BoxShadow(
                        color: alarm.gradientColor.last.withOpacity(0.2),
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: Offset(4, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.label,
                                color: Colors.white,
                                size: 24,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Example',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                          Switch(
                            value: true,
                            onChanged: (value) {},
                            activeColor: Colors.white,
                          ),
                        ],
                      ),
                      Text(
                        'Mon-Fri',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '08:00 AM',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const Icon(
                            Icons.arrow_drop_down_outlined,
                            size: 36,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }).followedBy([
                // DottedBorder가 Conatiner 타입으로 지정될 수 없다는 에러가 뜬다.
                // map에 Widget을 추가하면 해결
                // dashPattern 구성 원리
                // 홀: Dash, 짝: 빈칸
                // 3, 4 = 3개의 Dash 4개의 빈칸
                // 3, 5, 1, 10, = 3개의 Dash 5개의 빈칸 1개의 Dash 10개의 빈칸
                DottedBorder(
                  strokeWidth: 3,
                  color: CustomColors.clockOutline,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(cardRadius),
                  dashPattern: const [5, 10, 0],
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: CustomColors.clockBG,
                        borderRadius:
                            BorderRadius.all(Radius.circular(cardRadius))),
                    height: 100,
                    child: TextButton(
                      onPressed: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/add_alarm.png',
                            scale: 1.5,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Add Alarm',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ]).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
