import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier{
  int _amount = 0;
  int get amount => _amount;

  int _price = 0;
  int _notChangePrice = 0;
  int get price => _price;
  int get notChangePrice => _notChangePrice;

  void setAmount(int n){
    _amount = n;
  }

  void setPrice(int p){
    _price = p;
  }

  void setNotChange(int p){
    _notChangePrice = p;
  }

  void addAmount(){
    _amount++;
    _changePrice();
  }

  void decrease(){
    _amount--; _changePrice();
  }

  void _changePrice(){
    _price = _notChangePrice*_amount;
    notifyListeners();
  }

}