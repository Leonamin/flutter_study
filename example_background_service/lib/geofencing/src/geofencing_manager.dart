import 'dart:io';
import 'dart:ui';

import 'package:example_background_service/geofencing/src/callback_dispather.dart';
import 'package:example_background_service/geofencing/src/geofence_region.dart';
import 'package:example_background_service/geofencing/src/location.dart';
import 'package:example_background_service/geofencing/src/geofence_event.dart';
import 'package:flutter/services.dart';

class GeofencingManager {
  // TODO 채널이름 변경
  static const MethodChannel _channel =
      // MethodChannel('plugins.flutter.io/geofencing_plugin');
      MethodChannel('com.example.example_background_service');
  // TODO 채널 이름 변경
  static const MethodChannel _background =
      MethodChannel('plugins.flutter.io/geofencing_plugin_background');

  /// Initialize the plugin and request relevant permissions from the user.
  static Future<void> initialize() async {
    final CallbackHandle? callback =
        PluginUtilities.getCallbackHandle(callbackDispatcher);
    await _channel.invokeMethod('GeofencingPlugin.initializeService',
        <dynamic>[callback?.toRawHandle()]);
  }

  /// Promote the geofencing service to a foreground service.
  ///
  /// Will throw an exception if called anywhere except for a geofencing
  /// callback.
  static Future<void> promoteToForeground() async =>
      await _background.invokeMethod('GeofencingService.promoteToForeground');

  /// Demote the geofencing service from a foreground service to a background
  /// service.
  ///
  /// Will throw an exception if called anywhere except for a geofencing
  /// callback.
  static Future<void> demoteToBackground() async =>
      await _background.invokeMethod('GeofencingService.demoteToBackground');

  /// Register for geofence events for a [GeofenceRegion].
  ///
  /// `region` is the geofence region to register with the system.
  /// `callback` is the method to be called when a geofence event associated
  /// with `region` occurs.
  ///
  /// Note: `GeofenceEvent.dwell` is not supported on iOS. If the
  /// `GeofenceRegion` provided only requests notifications for a
  /// `GeofenceEvent.dwell` trigger on iOS, `UnsupportedError` is thrown.
  static Future<void> registerGeofence(
      GeofenceRegion region,
      void Function(List<String> id, Location location, GeofenceEvent event)
          callback) async {
    if (Platform.isIOS &&
        region.triggers.contains(GeofenceEvent.dwell) &&
        (region.triggers.length == 1)) {
      throw UnsupportedError("iOS does not support 'GeofenceEvent.dwell'");
    }
    final List<dynamic> args = <dynamic>[
      PluginUtilities.getCallbackHandle(callback)?.toRawHandle()
    ];
    args.addAll(region.toArgs());
    await _channel.invokeMethod('GeofencingPlugin.registerGeofence', args);
  }

  /// get all geofence identifiers
  static Future<List<String>> getRegisteredGeofenceIds() async =>
      List<String>.from(await _channel
          .invokeMethod('GeofencingPlugin.getRegisteredGeofenceIds'));

  /// Stop receiving geofence events for a given [GeofenceRegion].
  static Future<bool> removeGeofence(GeofenceRegion region) async =>
      (region == null) ? false : await removeGeofenceById(region.id);

  /// Stop receiving geofence events for an identifier associated with a
  /// geofence region.
  static Future<bool> removeGeofenceById(String id) async => await _channel
      .invokeMethod('GeofencingPlugin.removeGeofence', <dynamic>[id]);
}
