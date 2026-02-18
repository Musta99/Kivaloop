import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddStatusStateManegement extends ChangeNotifier {
  File? statusImageFile;
  void selectStatusImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File imageFile = File(image.path);
      statusImageFile = imageFile;
      notifyListeners();
    }
  }

  // -------------------------------------------------
  List searchedResult = [];
  Future<void> searchCoffeeShops(String query) async {
    try {
      EasyLoading.show();
      // final position = await getCurrentPosition();

      final url = Uri.parse(
        'https://api.mapbox.com/geocoding/v5/mapbox.places/${Uri.encodeComponent(query)}.json'
        '?access_token=mapboxToken&limit=25',
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        final features = data['features'] as List;
        searchedResult =
            features.map((e) => e['place_name'] as String).toList();
        notifyListeners();
        print(searchedResult);
      } else {
        searchedResult = [];
        notifyListeners();
      }
    } catch (err) {
      EasyLoading.showError(err.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  // --------------------------------------------
  String? searchedText;
  void setSearchedText(value) {
    searchedText = value;
    notifyListeners();
  }

  // -------------------------------------------
  bool isEditing = true;
  void changeEditability() {
    isEditing = !isEditing;
    notifyListeners();
  }

  // -------------------------------------------
  String? selectedCoffeeShop;
  void changeCoffeeShop(value) {
    selectedCoffeeShop = value;
    notifyListeners();
  }
}
