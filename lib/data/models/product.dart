import 'dart:collection';

class Product{
  String? name, des, price, imgUrl;

  Product({this.name, this.price, this.des, this.imgUrl});

  Product.fromJson(Map<dynamic, dynamic> e){
    name = e['Product Name'];
    des = e['Description'];
    price = '${e['Price']}';
    imgUrl = e['Product Image'][0]['url'];
  }

  Map<dynamic, dynamic> toJson(){
    Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['Product Name'] = name;
    data['Description'] = des;
    data['Price'] = double.parse(price!);
    data['Product Image'][0]['url'] = imgUrl;
    return data;
  }
}

class ProductListModel{
  List<Product> _lstProduct = [];
  UnmodifiableListView<Product> get lstProduct => UnmodifiableListView(_lstProduct);
  
  void setList(List<Product> lst){
    _lstProduct = lst;
  }

  List<Product> getList() => lstProduct;
}