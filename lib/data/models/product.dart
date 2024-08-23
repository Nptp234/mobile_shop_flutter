import 'dart:collection';

class Product{
  String? id, name, des, price, imgUrl, sold, starRating, categoryName;
  bool isWishlist = false;

  //combination
  Map<String, List<String>>? variantValues = {};
  Map<String, List<String>>? variantPrices = {};
  Map<String, List<String>>? variantStocks = {};

  Product({this.id, this.name, this.price, this.des, this.imgUrl, this.categoryName});

  Product.fromJson(Map<dynamic, dynamic> e){
    id = '${e['ID']}';
    name = e['Product Name'];
    des = e['Description'];
    price = '${e['Price']}';
    imgUrl = e['Product Image'][0]['url'];
    sold = '${e['Sold']}';
    starRating = '${e['Star Rating']}';
    categoryName = '${e['CategoryName']}';
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

  int compareTo(Product other) => name!.compareTo(other.name!);
}

class ProductListModel{
  //singleton
  ProductListModel._privateConstructor();

  // Static instance
  static final ProductListModel _instance = ProductListModel._privateConstructor();

  // Factory constructor to return the static instance
  factory ProductListModel() {
    return _instance;
  }
  //

  List<Product> _lstProduct = [];
  UnmodifiableListView<Product> get lstProduct => UnmodifiableListView(_lstProduct);
  
  void setList(List<Product> lst){
    _lstProduct = lst;
  }

  List<Product> getList() => lstProduct;
}