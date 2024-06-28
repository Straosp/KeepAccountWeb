import 'dart:async';

import 'package:flutter/material.dart';

class SelectionRadioController extends ChangeNotifier {

  int selectIndex = 0;

  final StreamController<int> _selectIndexStreamController = StreamController.broadcast();
  Stream<int> get selectIndexStream => _selectIndexStreamController.stream;

  void updateSelectIndex(int index){
    if (selectIndex == index) {
      return;
    }
    selectIndex = index;
    _selectIndexStreamController.add(index);
    notifyListeners();
  }

  int getSelectIndex() {
    return selectIndex;
  }


}