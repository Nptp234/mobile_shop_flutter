import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/data/models/cart.dart';

class CartProvider with ChangeNotifier{
  int _amount = 0;
  int get amount => _amount;

  int _price = 0;
  int _notChangePrice = 0;
  int get price => _price;
  int get notChangePrice => _notChangePrice;

  CartProvider();

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
class CartProviderList with ChangeNotifier {
  List<CartProvider> _cartPros = [];
  UnmodifiableListView<CartProvider> get cartPros => UnmodifiableListView(_cartPros);

  void _setProvider(Cart cart, CartProvider cartProvider) {
    cartProvider.setAmount(int.parse(cart.amount!));
    cartProvider.setPrice(int.parse(cart.totalPrice!));
    cartProvider.setNotChange(
        (double.parse(cart.totalPrice!) / double.parse(cart.amount!)).toInt());
  }

  void addCartPro(CartProvider cartP){
    _cartPros.add(cartP);
    notifyListeners();
  }

  void setListCartPro(List<Cart> lst){
    for(var cart in lst){
      CartProvider cartProvider = CartProvider();
      _setProvider(cart, cartProvider);
      _cartPros.add(cartProvider);
    }
  }
}