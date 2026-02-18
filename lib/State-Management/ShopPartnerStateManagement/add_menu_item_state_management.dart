import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddMenuItemStateManagement extends ChangeNotifier {
  // Select Menu Item Image
  File? menuItemImageFile;
  void selectMenuItem() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File imageFile = File(image.path);
      menuItemImageFile = imageFile;
      notifyListeners();
    }
  }
}
