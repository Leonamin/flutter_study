import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart' as t;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class TimeZone {
  factory TimeZone() => _instance;

  TimeZone._() {
    initializeTimeZones();
  }
  static final TimeZone _instance = TimeZone._();

  Future<String> getTimeZoneName() async =>
      FlutterNativeTimezone.getLocalTimezone();

  Future<t.Location> getLocation([String? timeZoneName]) async {
    if (timeZoneName == null || timeZoneName.isEmpty) {
      timeZoneName = await getTimeZoneName();
    }
    return t.getLocation(timeZoneName);
  }
}
