import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:image_picker/image_picker.dart';

class AddShopDetailsStateManagement extends ChangeNotifier {
  double? latitude;
  double? longitude;
  String shopAddress = "Your Shop Address";

  Future determineShopAddress() async {
    try {
      EasyLoading.show();

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
      latitude = position.latitude;
      longitude = position.longitude;
      notifyListeners();

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        print(
          '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}',
        );

        shopAddress =
            '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
        notifyListeners();
      }
    } catch (err) {
      EasyLoading.showError(err.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  // Select Shop Logo
  File? shopLogoImageFile;
  void selectShopLogo() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File imageFile = File(image.path);
      shopLogoImageFile = imageFile;
      notifyListeners();
    }
  }
}
