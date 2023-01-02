import "package:flutter/material.dart";

const Color kBackgroundColor = Color(0xFF2D2F41);
const Color kPrimaryColor = Color(0xFFFFBD73);

class CustomColors {
  static const primaryTextColor = Colors.white;
  static const dividerColor = Colors.white54;
  static const backgroundColor = Color(0xFF2D2F41);
  static const menuBackgroudColor = Color(0xFF242634);

  // clock
  static const clockBG = Color(0xFF444974);
  static const clockOutline = Color(0xFFEAECFF);
  static const secHandColor = Color(0xFFFFB742);
  static const minHandStatColor = Color(0xFF748EE6);
  static const minHandEndColor = Color(0xFF77DDFF);
  static const hourHandStatColor = Color(0xFFC279FB);
  static const hourHandEndColor = Color(0xFFEA74AB);
}

class GradientColors {
  final List<Color> colors;
  GradientColors(this.colors);

  static const List<Color> sky = [Color(0xFF6448FE), Color(0xFF5FC6FF)];
  static const List<Color> sunset = [Color(0xFFFE6197), Color(0xFFFFB463)];
  static const List<Color> sea = [Color(0xFF61A3FE), Color(0xFF63FFD5)];
  static const List<Color> mango = [Color(0xFFFFA738), Color(0xFFFFE130)];
  static const List<Color> fire = [Color(0xFFFF5DCD), Color(0xFFFF8484)];
}

class GradientTemplate {
  static final List<GradientColors> gradientTemplate = [
    GradientColors(GradientColors.sky),
    GradientColors(GradientColors.sunset),
    GradientColors(GradientColors.sea),
    GradientColors(GradientColors.mango),
    GradientColors(GradientColors.fire),
  ];
}
