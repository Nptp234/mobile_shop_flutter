import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mobile_shop_flutter/data/api/storage.dart';
import 'package:mobile_shop_flutter/data/models/product.dart';
import 'package:http/http.dart' as http;

class ProductAPI{
  ProductListModel productListModel = ProductListModel();

  Future<Map<dynamic, dynamic>> _getData() async{
    try{
      String? key = await read();
      String? url = await readUrl('productUrl');

      final res = await http.get(Uri.parse(url!), headers: {'Authorization':'Bearer $key'});
      if(res.statusCode==200){return jsonDecode(res.body);}
      else{return {};}
    }
    catch(e){
      rethrow;
    }
  }

  Future<List<Product>> getAll() async{
    try{
      final response = await _getData();

      List<Product> lst = [];

      for(var record in response['records']){
        var field = record['fields'];
        lst.add(Product.fromJson(field));
      }
      // productListModel.setList(lst);
      return lst;
    } 
    catch(e){
      rethrow;
    }
  }
}