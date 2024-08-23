import 'dart:collection';

class Cart{
  String? id, imgUrl, productID, productName, totalPrice, amount;
  Map<String, String> variantValues = {};

  Cart({this.id, this.imgUrl, this.productName, this.totalPrice, this.amount});

  Cart.fromJson(Map<dynamic, dynamic> e){
    id = e['ID'];
    imgUrl = e['ProductImage'][0]['url'];
    productName = e['ProductName'];
    totalPrice = '${e['TotalPrice']}';
    amount = '${e['Amount']}';
  }

  void addVariant(String variant, dynamic values) {
    variantValues[variant] = values.toString();
  }
}

class CartListModel{
  List<Cart> _lstCart = [];
  UnmodifiableListView<Cart> get lstCart => UnmodifiableListView(_lstCart);
  
  void setList(List<Cart> lst){
    _lstCart = lst;
  }
  void add(Cart cart){
    _lstCart.add(cart);
  }
  void removeAt(int index){
    _lstCart.removeAt(index);
  }
  void clear(){
    _lstCart.clear();
  }

  List<Cart> getList() => lstCart;
}