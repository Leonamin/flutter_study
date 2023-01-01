import 'package:flutter/animation.dart';

class AlarmInfo {
  DateTime alarmDateTime;
  String? description;
  bool isActive;
  List<Color> gradientColor;

  AlarmInfo({
    required this.alarmDateTime,
    this.description,
    required this.isActive,
    required this.gradientColor,
  });
}
