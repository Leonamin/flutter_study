import 'package:clock_app_tutorial/config/constants/theme_data.dart';
import 'package:clock_app_tutorial/models/alarm_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlarmCard extends StatelessWidget {
  final AlarmInfo alarmInfo;
  const AlarmCard({super.key, required this.alarmInfo});

  static const double cardRadius = 24;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: GradientTemplate
              .gradientTemplate[alarmInfo.gradientColorIndex].colors,
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
            color: GradientTemplate
                .gradientTemplate[alarmInfo.gradientColorIndex].colors.last
                .withOpacity(0.2),
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
                    alarmInfo.title ?? "",
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
                DateFormat("HH:mm").format(alarmInfo.alarmDateTime),
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
  }
}
