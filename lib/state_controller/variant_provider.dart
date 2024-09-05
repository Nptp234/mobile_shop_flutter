import 'dart:collection';

import 'package:flutter/material.dart';

class VariantProvider with ChangeNotifier{
  // 2 variant => 2 extra price
  // num _extraPrice = extraPrice 1 + extraPrice 2
  int _extraPrice = 0;
  int get extraPrice => _extraPrice;

  int _stock = 0;
  int get stock => _stock;

  final Map<String, int> _variantPrices = {};
  final Map<String, String> _variants = {};
  UnmodifiableMapView<String, String> get variants => UnmodifiableMapView(_variants);
  UnmodifiableMapView<String, int> get variantPrices => UnmodifiableMapView(_variantPrices);


  changeExtraPrice(String variantName, int p){
    _variantPrices[variantName] = p;
    _extraPrice = _variantPrices.values.fold(0, (sum, item) => sum+item);
    notifyListeners();
  }

  addVaraints(String variantName, String variantValue, int price){
    _variants[variantName] = variantValue;
    changeExtraPrice(variantName, price);
  }

  changeStock(int amount){
    _stock = amount;
    notifyListeners();
  }
}