import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  TextEditingController _searchController = TextEditingController();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const Marker _kGooglePlexMarker = Marker(
      markerId: MarkerId('kGooglePlex'),
      infoWindow: InfoWindow(title: 'Google Plex'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(37.42796133580664, -122.085749655962));

  static final Marker _kLakeMarker = Marker(
      markerId: MarkerId('kLakePlex'),
      infoWindow: InfoWindow(title: 'lake x'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      position: LatLng(37.42796133580664, -122.0840));

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  static final Polyline _kPolyline = Polyline(
      polylineId: PolylineId('asdasdad'),
      points: [
        LatLng(37.42796133580664, -122.085749655962),
        LatLng(37.42796133580664, -122.0840),
      ],
      width: 5,
      color: Colors.yellow);

  static final Polygon _kPolygon = Polygon(
      polygonId: PolygonId('asdadad'),
      points: [
        LatLng(37.42796133580664, -122.085749655962),
        LatLng(37.42796133580664, -122.0840),
        LatLng(37.418, -122.092),
        LatLng(37.435, -122.092),
      ],
      strokeWidth: 5,
      fillColor: Colors.transparent);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: TextFormField(
                controller: _searchController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(hintText: '도시 검색'),
                onChanged: (value) {
                  print(value);
                },
              )),
              IconButton(onPressed: () {}, icon: Icon(Icons.search))
            ],
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.satellite,
              markers: {_kGooglePlexMarker, _kLakeMarker},
              polylines: {_kPolyline},
              polygons: {_kPolygon},
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: Text('To the lake!'),
      //   icon: Icon(Icons.directions_boat),
      // ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
