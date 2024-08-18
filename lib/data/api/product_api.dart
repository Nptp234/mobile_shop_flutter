import 'dart:convert';

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

  Future<Map<dynamic, dynamic>> _getDataVariant() async{
    try{
      String? key = await read();
      String? url = await readUrl('combinationtUrl');

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

  Future<Product> _getOne(String id) async{
    try{
      final responseOne = await _getData();
      for(var record in responseOne['records']){
        var fields = record['fields'];
        if(fields['ID'] == int.parse(id)){
          return Product.fromJson(fields);
        }
      }
      return Product();
    }
    catch(e){
      rethrow;
    }
  }

  Future<Product> getVariantProduct(String id) async{
    try{
      final response = await _getDataVariant();
      final Product product = await _getOne(id);

      // Extract variants and values for the product
      for (var record in response['records']) {
        var fields = record['fields'];
        if (fields['ProductID'][0] == int.parse(id)) {
          if(fields['VariantName'][0]=='Color'){
            product.addVariant(fields['VariantName'][0], fields['Values'], fields['ExtraPrice'], fields['StockAmount']);
          }else{
            product.addVariant(fields['VariantName'][0], fields['ValueName'], fields['ExtraPrice'], fields['StockAmount']);
          }
        }
      }

      return product;
    }
    catch(e){
      rethrow;
    }
  }
}