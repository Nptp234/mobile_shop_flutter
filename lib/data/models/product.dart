import 'dart:collection';

class Product{
  String? id, name, des, price, imgUrl, sold, starRating;
  bool isWishlist = false;

  //combination
  Map<String, List<String>>? variantValues = {};
  Map<String, List<String>>? variantPrices = {};
  Map<String, List<String>>? variantStocks = {};

  Product({this.id, this.name, this.price, this.des, this.imgUrl});

  Product.fromJson(Map<dynamic, dynamic> e){
    id = '${e['ID']}';
    name = e['Product Name'];
    des = e['Description'];
    price = '${e['Price']}';
    imgUrl = e['Product Image'][0]['url'];
    sold = '${e['Sold']}';
    starRating = '${e['Star Rating']}';
  }

  Map<dynamic, dynamic> toJson(){
    Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['ID'] = int.parse(id!);
    data['Product Name'] = name;
    data['Description'] = des;
    data['Price'] = double.parse(price!);
    data['Product Image'][0]['url'] = imgUrl;
    return data;
  }

  void addVariant(String variant, List<dynamic> values, List<dynamic> extraPrice, List<dynamic> stocks) {
    List<String> stringValues = values.map((value) => value.toString()).toList();
    List<String> stringPrices = extraPrice.map((value) => value.toString()).toList();
    List<String> stringStocks = stocks.map((value) => value.toString()).toList();

    if (!variantValues!.containsKey(variant)) {
      variantValues![variant] = stringValues;
      variantPrices![variant] = stringPrices;
      variantStocks![variant] = stringStocks;
    } else {
      // Merge new values with existing values if necessary
      variantValues![variant] = variantValues![variant]!.toSet().union(stringValues.toSet()).toList();
      variantPrices![variant] = variantPrices![variant]!.toSet().union(stringPrices.toSet()).toList();
      variantStocks![variant] = variantStocks![variant]!.toSet().union(stringStocks.toSet()).toList();
    }
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