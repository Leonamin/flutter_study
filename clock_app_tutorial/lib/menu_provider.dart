import 'package:clock_app_tutorial/menu_routes.dart';
import 'package:flutter/cupertino.dart';

class MenuProvider extends ChangeNotifier {
  String activeItem = ClockMenuDisplayName;
  String hoverItem = "";

  bool isActive(String itemName) => activeItem == itemName;
  bool isHovering(String itemName) => hoverItem == itemName;

  changeActiveItemTo(String itemName) {
    activeItem = itemName;
    notifyListeners();
  }

  onHover(String itemName) {
    if (!isActive(itemName)) {
      hoverItem = itemName;
    }
    notifyListeners();
  }

  String returnIconFor(String itemName) {
    switch (itemName) {
      case ClockMenuDisplayName:
        return 'assets/clock_icon.png';
      case AlarmMenuDisplayName:
        return 'assets/alarm_icon.png';
      case TimerMenuDisplayName:
        return 'assets/timer_icon.png';
      case StopwatchMenuDisplayName:
        return 'assets/stopwatch_icon.png';

      default:
        return 'assets/clock_icon.png';
    }
  }
}
