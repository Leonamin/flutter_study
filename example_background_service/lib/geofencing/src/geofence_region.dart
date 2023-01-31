// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:example_background_service/geofencing/src/location.dart';
import 'package:example_background_service/geofencing/src/geofence_event.dart';
import 'package:example_background_service/geofencing/src/platform_settings.dart';

/// A circular region which represents a geofence.
class GeofenceRegion {
  /// The ID associated with the geofence.
  ///
  /// This ID is used to identify the geofence and is required to delete a
  /// specific geofence.
  final String id;

  /// The location of the geofence.
  final Location location;

  /// The radius around `location` that will be considered part of the geofence.
  final double radius;

  /// The types of geofence events to listen for.
  ///
  /// Note: `GeofenceEvent.dwell` is not supported on iOS.
  final List<GeofenceEvent> triggers;

  /// Android specific settings for a geofence.
  final AndroidGeofencingSettings androidSettings;

  GeofenceRegion(
    this.id,
    double latitude,
    double longitude,
    this.radius,
    this.triggers, {
    AndroidGeofencingSettings? androidSettings,
  })  : location = Location(latitude, longitude),
        androidSettings = (androidSettings ?? AndroidGeofencingSettings());

  List<dynamic> toArgs() {
    final int triggerMask = triggers.fold(
        0, (int trigger, GeofenceEvent e) => (geofenceEventToInt(e) | trigger));
    final List<dynamic> args = <dynamic>[
      id,
      location.latitude,
      location.longitude,
      radius,
      triggerMask
    ];
    if (Platform.isAndroid) {
      args.addAll(platformSettingsToArgs(androidSettings));
    }
    return args;
  }
}
