import 'dart:collection';

class Product{
  String? id, name, des, price, imgUrl, sold, starRating;

  //combination
  List<String>? variant, value;
  Map<String, List<String>>? variantValues = {};

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

  setVariantList(List<String> variants){
    variant = variants;
  }
  setValueList(List<String> values){
    value = values;
  }
  fromJsonVariants(Map<dynamic, dynamic> e){
    for(var i in e['records']){
      if(i['fields']['ProductID'][0]==id){
        variant!.add(i['fields']['VariantName']);
      }
    }
  }
  fromJsonValues(Map<dynamic, dynamic> e){
    value = e['ValueName'];
  }
  void addVariant(String variant, List<dynamic> values) {
    List<String> stringValues = values.map((value) => value.toString()).toList();
    if (!variantValues!.containsKey(variant)) {
      variantValues![variant] = stringValues;
    } else {
      // Merge new values with existing values if necessary
      variantValues![variant] = variantValues![variant]!.toSet().union(stringValues.toSet()).toList();
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