import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'listColor.dart';

class RiverpodSettingsModel extends ChangeNotifier {

  Item? _colorSelected;
  int intColor = 0xFF214A1F;

  Color get colorSelected => _colorSelected?.color ?? Color(intColor);
  String get colorSelectedName=> _colorSelected?.name ?? "green";

  void updateColorSelected(Item color) {
    _colorSelected = color;
    notifyListeners();
  }

  void updateIntColor(int intcolor){
    intColor = intcolor;
  }
}