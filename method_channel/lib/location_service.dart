import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LocationService {
  static const MethodChannel _channel =
      MethodChannel('com.example.method_channel');

  Future<dynamic> getCurrentLocation() async {
    dynamic location;
    try {
      location = await _channel.invokeMethod('getCurrentLocation');
    } on PlatformException catch (e) {
      debugPrint(e.message);
      return null;
    }
    return location;
  }
}
