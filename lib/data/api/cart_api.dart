import 'dart:convert';

import 'package:mobile_shop_flutter/data/api/storage.dart';
import 'package:mobile_shop_flutter/data/models/cart.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_shop_flutter/data/models/product.dart';
import 'package:mobile_shop_flutter/data/models/user.dart';
import 'package:mobile_shop_flutter/state_controller/variant_provider.dart';

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
        List<dynamic> filteredRecordsList = data['records'].where((record) {
          return record['fields']['CustomerID'] == user.id;
        }).toList();

        // Convert the filtered list back into a map structure
        Map<dynamic, dynamic> filteredRecords = {
          'records': filteredRecordsList,
        };

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
        Cart cart = Cart.fromJson(field);
        for(int i=0; i<field['VariantName'].length; i++){
          cart.addVariant(field['VariantName'][i], field['VariantValue'][i]);
        }
        lst.add(cart);
      }
      return lst;
    }
    catch(e){
      rethrow;
    }
  }

  Future<bool> addCart(Product product, VariantProvider value) async{
    try{
      String? key = await read();
      String? url = await readUrl('cartUrl');

      int extra = value.variantPrices.values.fold(0, (sum, item) => sum + item);
      String variantNames = value.variants.keys.join(', ');
      String variantValues = value.variants.values.map((v) => v.toString()).join(', ');

      final body = {
            "records":[
                {
                    "fields":{
                        "CustomerID": user.id,
                        "CustomerUsername": user.username,
                        "CustomerEmail": user.email,
                        "ProductID": product.id,
                        "ProductName": product.name,
                        "VariantName": value.variants.keys.toList(),
                        "VariantValue": value.variants.values.toList(),
                        "Amount": 3,
                        "ProductPrice": int.parse(product.price!),
                        "VariantExtra": extra
                    }
                }
            ]
        };

      final res = await http.post(
        Uri.parse(url!),
        headers: {
          'Authorization': 'Bearer $key',
          'Content-Type':'application/json'
        },
        body: jsonEncode(body)
      );
      if(res.statusCode==200){
        return true;
      }else{return false;}
    }
    catch(e){
      rethrow;
    }
  }
}