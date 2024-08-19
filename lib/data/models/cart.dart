import 'dart:collection';

class Cart{
  String? id, imgUrl, productName, totalPrice, amount;
  Map<String, dynamic> variantValues = {};

  Cart({this.id, this.imgUrl, this.productName, this.totalPrice, this.amount});

  Cart.fromJson(Map<dynamic, dynamic> e){
    id = e['ID'];
    imgUrl = e['ProductImage'][0]['url'];
    productName = e['ProductName'];
    totalPrice = '${e['TotalPrice']}';
    amount = '${e['Amount']}';
  }

  void addVariant(String variant, List<dynamic> values) {
    List<String> stringValues = values.map((value) => value.toString()).toList();

    if (!variantValues.containsKey(variant)) {
      variantValues[variant] = stringValues;
    } else {
      // Merge new values with existing values if necessary
      variantValues[variant] = variantValues[variant]!.toSet().union(stringValues.toSet()).toList();
    }
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