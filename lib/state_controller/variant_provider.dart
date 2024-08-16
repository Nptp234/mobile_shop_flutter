import 'package:flutter/material.dart';

class VariantProvider with ChangeNotifier{
  int _extraPrice = 0;
  int get extraPrice => _extraPrice;


  changeExtraPrice(int p){
    _extraPrice = p;
    notifyListeners();
  }
}