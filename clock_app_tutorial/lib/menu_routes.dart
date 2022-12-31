const ClockMenuDisplayName = "Clock";
const AlarmMenuDisplayName = "Alarm";
const TimerMenuDisplayName = "Timer";
const StopwatchMenuDisplayName = "Stopwatch";

const ClockMenuRoute = "/clock";
const AlarmMenuRoute = "/alarm";
const TimerMenuRoute = "/timer";
const StopwatchMenuRoute = "/stopwatch";

class MenuItem {
  final String name;
  final String route;
  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItems = [
  MenuItem(ClockMenuDisplayName, ClockMenuRoute),
  MenuItem(AlarmMenuDisplayName, AlarmMenuRoute),
  MenuItem(TimerMenuDisplayName, TimerMenuRoute),
  MenuItem(StopwatchMenuDisplayName, StopwatchMenuRoute),
];
