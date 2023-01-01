import 'package:clock_app_tutorial/config/constants/theme_data.dart';
import 'package:clock_app_tutorial/config/route/menu_routes.dart';
import 'package:clock_app_tutorial/models/alarm_info.dart';
import 'package:clock_app_tutorial/models/menu_item.dart';

List<MenuItem> sideMenuItems = [
  MenuItem(ClockMenuDisplayName, ClockMenuRoute),
  MenuItem(AlarmMenuDisplayName, AlarmMenuRoute),
  MenuItem(TimerMenuDisplayName, TimerMenuRoute),
  MenuItem(StopwatchMenuDisplayName, StopwatchMenuRoute),
];

List<AlarmInfo> alarms = [
  AlarmInfo(
      alarmDateTime: DateTime.now().add(Duration(hours: 1)),
      isActive: false,
      gradientColor: GradientColors.sky),
  AlarmInfo(
      alarmDateTime: DateTime.now().add(Duration(hours: 1)),
      isActive: false,
      gradientColor: GradientColors.sunset),
];
