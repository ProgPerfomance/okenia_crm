import 'package:flutter/material.dart';

class MainViewmodel extends ChangeNotifier {

  int _pageIndex = 0;

  int get pageIndex => _pageIndex;

  void selectPage (int index) {
    _pageIndex = index;
    notifyListeners();
  }

}

