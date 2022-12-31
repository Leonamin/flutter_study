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
    super.initState();
    _ticker = createTicker((elapsed) {
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
      // 강의 영상에 알려준방식
      // 이러면 90도 보정을 안해도 된다.
      // child: Transform.rotate(
      //     angle: -pi / 2,
      //     child: CustomPaint(painter: ClockPainter(dateTime: datetime))),
    );
  }
}

class ClockPainter extends CustomPainter {
  ClockPainter({required this.dateTime});

  DateTime dateTime;

  /*
  즐거운 수학시간
  내 수학실력은 망했다. 삼각함수조차 제대로 응용을 못하네

  360˚를 시분초로 나누면 다음과 같다
  초 - 60 360 / 60 = 6˚
  분 - 60 360 / 60 = 6˚
  시 - 12 360 / 12 = 30˚

  sin(θ) = y / r
  cos(θ) = x / r

  ∴ x = cosθ * r
  ∴ y = sinθ * r

  -호도법과 60분법-
  반지름 길이가 r인 원에서 반지름과 같은 호 AB의 각을 a˚라고 할 경우
  360˚ : 2πr = a˚ : r
  호의 길이r은 중심각 a˚(1rad)에 비례하므로 호의 전체 길이인 원의 둘레는 360˚가 된다. 
  각 항을 이동하고 없애면 최종적으로
  a˚ = 180˚ / π가 된다.
  여기서 a˚를 1 라디안이라고 한다.

  1rad = 180˚ / π 이므로 이걸 또 옆으로 옮기면


  1˚ = π / 180 rad가 된다.

  그리고 여기서 라디안은 일반적으로 생략해서 그냥 1은 180˚ / π라고 말한다.

  -삼각함수로 좌표 얻기-
  여기서 r는 시계바늘의 길의가 될 것이다.

  그리고 θ = 0일 경우 x = r y = 0이 되며 시초선은 3시 방향이다.

  θ가 양의 방향으로 커질 수록 반시계방향으로 x,y 좌표가 변한다.

  그렇기에 최종적으로 식은 아래와 같다
  x = cos(θ) * r
    = cos(a˚ * pi / 180)  * r
  여기에서 페인터상에서 그리려면 중앙좌표 centerX를 더해야한다
  a˚ = (현재 시간 * 초분시각도)
  r = 시계 바늘 길이

  그렇다면 시간을 구하기 위해서는 일단 θ에 90을 더하고 각도를 -로 해야한다.

  근데 왜 90도를 -해야 정위치가 되는거지? 90도를 더해야하는거 아닌가?

  + 찾아냈다.
  수식은 맞다 하지만 이건 말그대로 수학 그래프 상에서에 얘기고 실제 flutter 환경은 왼쪽 상단이 0,0 오른쪽 하단이 N,N 좌표이다.
  그래서 CustomPainter 좌표로 보정이 필요하다.
  x는 증가량은 정상적으로 표시가 되지만 감소량은 음수가 되기 때문에 중앙값을 더하면 되고
  y는 값이 증가하면 위치가 아래로 향하기 때문에 중앙값 - 구한 Y 좌표를 넣으면 된다.
  CustomPainter 좌표
  0,0, N,0
  0,N  N,N
  */
  final secDegree = 6.0;
  final minDegree = 6.0;
  final hourDegree = 30.0;

  Offset _degreeOffset(double centerX, double centerY, int len, double degree) {
    //     final degree = timeDrgree * time - 90;
    // final dx = center + len * cos(degree * radian);
    // final dy = center + len * sin(degree * radian);
    // 위젯 자체를 rotate 해버리면 90은 없애도 된다.
    // -degree는 음의 방향 증가가 시계 방향이라서 남겨야함
    final x = len * cos((90 - degree) * pi / 180);
    final y = len * sin((90 - degree) * pi / 180);
    final dx = x + centerX;
    final dy = centerY - y;
    // debugPrint(
    //     "center=($centerX, $centerY), (x, y) = ($x, $y), (dx, dy)=($dx, $dy)");
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

    final dashBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    // LIFO 마지막으로 그린게 첫번째로 올라간다

    canvas.drawCircle(center, radius - 40, circleBrush);
    canvas.drawCircle(center, radius - 40, circleOutlineBrush);

    // 시계 바늘
    canvas.drawLine(
      center,
      _degreeOffset(
        centerX,
        centerY,
        80,
        // 1초의 간격은 6도이며 그 1초 안에서 1000밀리초의 간격은 0.006이다
        dateTime.second * secDegree + dateTime.millisecond * 0.006,
      ),
      secHandBrush,
    );
    canvas.drawLine(
      center,
      _degreeOffset(
        centerX,
        centerY,
        70,
        // 1분의 간격은 6도이며 그 6도안에서 60초의 간격은 0.1도이다.
        dateTime.minute * minDegree + dateTime.second * 0.1,
      ),
      minHandBrush,
    );
    canvas.drawLine(
      center,
      _degreeOffset(
        centerX,
        centerY,
        60,
        // 1시간의 간격은 30도이며 그 30도안에서 60분의 간격은 0.5도이다.
        ((dateTime.hour % 12) * hourDegree) + (dateTime.minute * 0.5),
      ),
      hourHandBrush,
    );

    // 14의 길이가
    var outerCircleRadius = radius;
    var innerCircleRadius = radius - 14;

    // 30개를 원형으로 그린다.
    for (int i = 0; i <= 360; i += 12) {
      canvas.drawLine(
        _degreeOffset(
            centerX, centerY, innerCircleRadius.toInt(), i.toDouble()),
        _degreeOffset(
            centerX, centerY, outerCircleRadius.toInt(), i.toDouble()),
        dashBrush,
      );
    }

    canvas.drawCircle(center, 16, circleCenterFillBrush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
