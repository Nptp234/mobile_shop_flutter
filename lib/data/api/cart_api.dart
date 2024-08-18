import 'dart:convert';

import 'package:mobile_shop_flutter/data/api/storage.dart';
import 'package:mobile_shop_flutter/data/models/cart.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_shop_flutter/data/models/user.dart';

class CartAPI{
  CartListModel cartListModel = CartListModel();
  final user = User();

  Future<Map<dynamic, dynamic>> _getData() async{
    try{
      String? key = await read();
      String? url = await readUrl('cartUrl');

      final res = await http.get(Uri.parse(url!), headers: {'Authorization':'Bearer $key'});
      if(res.statusCode==200){
        final data = jsonDecode(res.body);
        Map<dynamic, dynamic> filteredRecords = data['records'].where((record) {
          return record['CustomerID'] == user.id;
        }).toList();

        return filteredRecords;
      }
      else{return {};}
    }
    catch(e){
      rethrow;
    }
  }

  Future<List<Cart>> getList() async{
    try{
      final response = await _getData();
      List<Cart> lst = [];
      for(var record in response['records']){
        var field = record['fields'];
        lst.add(Cart.fromJson(field));
      }
      return lst;
    }
    catch(e){
      rethrow;
    }
  }
}