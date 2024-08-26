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
          return record['fields']['CustomerID'][0] == user.id;
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

      final body = {
            "records":[
                {
                    "fields":{
                        "Customer": user.id,
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

  Future<bool> updateAmount(int amount, String id) async{
    try{
      String? key = await read();
      String? url = await readUrl('cartUrl');

      final body = {
        "records":[
            {
              "fields":{
                "ID": id,
                "Amount": amount,
              }
            }
          ]
      };

      final res = await http.patch(
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

  Future<bool> checkSameCart(Product product, VariantProvider value) async{
    try{
      List<Cart> existingCarts = await getList();

      Cart existingCart=Cart();
      existingCart = existingCarts.firstWhere(
        (cart) => cart.productID == product.id &&_areVariantsEqual(cart.variantValues, value.variants),
      );

      if(existingCart.id==null){
        return false;
      }else{
        return true;
      }
    }
    catch(e){
      rethrow;
    }
  }

  // Helper method to compare variants
  bool _areVariantsEqual(Map<String, String> cartVariants, Map<String, String> newVariants) {
    if (cartVariants.length != newVariants.length) {
      return false;
    }

    for (String key in cartVariants.keys) {
      if (!newVariants.containsKey(key) || cartVariants[key] != newVariants[key]) {
        return false;
      }
    }

    return true;
  }
}