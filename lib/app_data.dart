import 'package:flutter/material.dart';

class AppData extends ChangeNotifier {
  int searchedSeat = 0;

  setSearchedSeat(int newSeat) {
    searchedSeat = newSeat;
    notifyListeners();
  }
}
