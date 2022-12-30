import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ClockView extends StatefulWidget {
  const ClockView({super.key});

  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  Duration _elapsed = Duration.zero;
  DateTime datetime = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    _ticker = this.createTicker((elapsed) {
      setState(() {
        _elapsed = elapsed;
        datetime = DateTime.now();
      });
    });
    _ticker.start();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: CustomPaint(painter: ClockPainter(dateTime: datetime)),
    );
  }
}

class ClockPainter extends CustomPainter {
  ClockPainter({required this.dateTime});

  DateTime dateTime;

  /*
  즐거운 수학시간
  내 수학실력은 망했다. 삼각함수조차 제대로 응용을 못하네

  360도를 시분초로 나누면 다음과 같다
  초 - 60 360 / 60 = 6도
  분 - 60 360 / 60 = 6도
  시 - 12 360 / 12 = 30도

  sinθ = y / r
  cosθ = x / r

  여기서 r는 시계바늘의 길의가 될 것이다.
  sinθ으로는 y좌표를, cosθ로는 x좌표를 구할 수 있다.

  그리고 θ = 0일 경우 x = r y = 0이 된다.
  즉 12시 방향이 아니라 3시 방향이다.
  θ가 커질 수록 반시계방향으로 x,y 좌표가 변한다.

  그렇다면 시간을 구하기 위해서는 일단 θ에 90을 더하고 각도를 -로 해야한다.

  근데 왜 90도를 -해야 정위치가 되는거지? 90도를 더해야하는거 아닌가?

  */
  final secDegree = 6;
  final minDegree = 6;
  final hourDegree = 30;

  double get radian => pi / 180;

  Offset _timeOffset(double center, int len, int timeDrgree, int time) {
    final degree = timeDrgree * time - 90;
    final dx = center + len * cos(degree * radian);
    final dy = center + len * sin(degree * radian);
    return Offset(dx, dy);
  }

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    // 위젯 크기가 정사각형이 아니면 항상 작은 걸로
    var radius = min(centerX, centerY);

    final circleBrush = Paint()..color = const Color(0xFF444974);

    final circleOutlineBrush = Paint()
      ..color = const Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke // 가장자리
      ..strokeWidth = 16;

    final circleCenterFillBrush = Paint()..color = const Color(0xFFEAECFF);

    final secHandBrush = Paint()
      ..color = Colors.orange[300]!
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;
    final minHandBrush = Paint()
      ..shader =
          const RadialGradient(colors: [Color(0xFF748EF6), Color(0xFF77DDFF)])
              .createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10;
    final hourHandBrush = Paint()
      ..shader =
          const RadialGradient(colors: [Color(0xFFEA74AB), Color(0xFFC279FB)])
              .createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12;

    // LIFO 마지막으로 그린게 첫번째로 올라간다
    canvas.drawCircle(center, radius - 40, circleBrush);
    canvas.drawCircle(center, radius - 40, circleOutlineBrush);

    var secHandLen = 80;
    var secHandX = centerX + secHandLen * sin(0 * pi / 180);
    var secHandY = centerY + secHandLen * cos(0 * pi / 180);

    canvas.drawLine(
      center,
      _timeOffset(centerX, 80, secDegree, dateTime.second),
      secHandBrush,
    );
    canvas.drawLine(
      center,
      _timeOffset(centerX, 70, minDegree, dateTime.minute),
      minHandBrush,
    );
    canvas.drawLine(
      center,
      _timeOffset(centerX, 60, hourDegree, dateTime.hour % 12),
      hourHandBrush,
    );

    canvas.drawCircle(center, 16, circleCenterFillBrush);

    // canvas.drawRect(
    //     Rect.fromCircle(center: center, radius: radius - 40), squareBrush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
