import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geo;

class UserLocationStateManagement extends ChangeNotifier {
  double? latitude;
  double? longitude;
  void determinePosition(BuildContext context) async {
    bool serviceEnabled;
    geo.LocationPermission permission;

    serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await geo.Geolocator.checkPermission();
    if (permission == geo.LocationPermission.denied) {
      permission = await geo.Geolocator.requestPermission();
      if (permission == geo.LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == geo.LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    geo.Position position = await geo.Geolocator.getCurrentPosition(
      desiredAccuracy: geo.LocationAccuracy.high,
    );
    // if (!mounted) return;

    latitude = position.latitude;
    longitude = position.longitude;
    notifyListeners();

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text("${latitude!.toString()}, ${longitude!.toString()}"),
    //   ),
    // );
  }
}
