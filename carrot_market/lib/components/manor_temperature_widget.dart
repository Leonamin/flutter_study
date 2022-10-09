import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ManorTemperatureWidget extends StatelessWidget {
  double manorTemp;
  late final int level;

  final List<Color> tempColors = [
    const Color(0xFF072038),
    const Color(0xFF0D3A65),
    const Color(0xFF186EC0),
    const Color(0xFF37B24D),
    const Color(0xFFFFAD13),
    const Color(0xFFF76707),
  ];

  ManorTemperatureWidget({Key? key, required this.manorTemp})
      : super(key: key) {
    _calcTempLevel();
  }

  void _calcTempLevel() {
    if (manorTemp <= 20) {
      level = 0;
    } else if (manorTemp > 20 && manorTemp <= 32) {
      level = 1;
    } else if (manorTemp > 32 && manorTemp <= 36.5) {
      level = 2;
    } else if (manorTemp > 36.5 && manorTemp <= 40) {
      level = 3;
    } else if (manorTemp > 40 && manorTemp <= 50) {
      level = 4;
    } else {
      level = 5;
    }
  }

  Widget _progressIndigator({
    required double value,
    required double height,
    required double width,
    Color color = Colors.green,
    Color backgroundColor = Colors.black12,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: height,
        color: backgroundColor,
        child: Row(
          children: [
            Container(
              height: height,
              width: width / 100 * manorTemp,
              color: color,
            )
          ],
        ),
      ),
    );
  }

  Widget _makeTempLabelAndBar() {
    return Container(
      width: 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$manorTemp°C",
            style: TextStyle(
                color: tempColors[level],
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          _progressIndigator(value: manorTemp, height: 6, width: 60)
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(10),
          //   child: Container(
          //     height: 6,
          //     color: Colors.black.withOpacity(0.2),
          //     child: Row(
          //       children: [
          //         Container(
          //           height: 6,
          //           width: 60 / 100 * manorTemp,
          //           color: tempColors[level],
          //         )
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            _makeTempLabelAndBar(),
            Container(
              margin: const EdgeInsets.only(left: 7),
              width: 30,
              height: 30,
              child: Image.asset(
                "assets/images/level-$level.jpg",
              ),
            )
          ],
        ),
        const Text(
          "매너온도",
          style: TextStyle(
              color: Colors.black38,
              fontSize: 12,
              decoration: TextDecoration.underline),
        )
      ],
    );
  }
}
