import 'dart:collection';

class Cart{
  String? id, imgUrl, productName, totalPrice, amount;
  Map<String, dynamic> variants = {};

  Cart({this.id, this.imgUrl, this.productName, this.totalPrice, this.amount});

  Cart.fromJson(Map<dynamic, dynamic> e){
    id = e['ID'];
    imgUrl = e['ImageProduct'];
    productName = e['ProductName'];
    totalPrice = '${e['TotalPrice']}';
    amount = '${e['Amount']}';
  }
}

class CartListModel{
  List<Cart> _lstCart = [];
  UnmodifiableListView<Cart> get lstCart => UnmodifiableListView(_lstCart);
  
  void setList(List<Cart> lst){
    _lstCart = lst;
  }

  List<Cart> getList() => lstCart;
}