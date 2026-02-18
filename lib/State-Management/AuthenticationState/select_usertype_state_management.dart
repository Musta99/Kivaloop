import 'package:flutter/material.dart';

class SelectUsertypeStateManagement extends ChangeNotifier {
  int selectedUserIndex = 0;

  void chooseUserType(index) {
    selectedUserIndex = index;
    notifyListeners();
  }
}
