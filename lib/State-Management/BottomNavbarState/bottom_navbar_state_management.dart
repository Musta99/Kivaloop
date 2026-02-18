import 'package:flutter/material.dart';

class BottomNavbarStateManagement extends ChangeNotifier {
  int selectedIndex = 0;
  void changeBottomNavbar(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
