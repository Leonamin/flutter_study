import 'package:flutter/services.dart';

class DevicePowerService {
  static const MethodChannel _channel =
      MethodChannel('com.example.method_channel');

  // 배터리 레벨을 가져옵니다.
  Future<dynamic> getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await _channel.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
      print(batteryLevel);
      return null;
    }
    return batteryLevel;
  }
}
