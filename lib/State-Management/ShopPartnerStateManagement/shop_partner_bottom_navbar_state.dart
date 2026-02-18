import 'package:flutter/material.dart';

class ShopPartnerBottomNavbarState extends ChangeNotifier {
  int selectedIndex = 0;

  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
