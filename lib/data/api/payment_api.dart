import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_shop_flutter/data/api/storage.dart';
import 'package:mobile_shop_flutter/data/models/payment.dart';

class PaymentApi {


  Future<http.Response> _getData() async{
    try{
      String? key = await read();
      String? url = await readUrl('paymentUrl');

      final res = await http.get(
        Uri.parse(url!), 
        headers: {
          'Authorization': 'Bearer $key',
          'Content-Type': 'application/json'
        }
      );
      return res;
    }
    catch(e){
      rethrow;
    }
  }

  Future<List<Payment>> getAll() async{
    try{
      final response = await _getData();

      if(response.statusCode==200){
        final body = jsonDecode(response.body);

        // List<Payment> lst = [];
        // for(var record in body['records']){
        //   var field = record['fields'];
        //   lst.add(Payment.fromJson(field));
        // }
        // return lst;

        return (body['records'] as List)
          .map((record) => Payment.fromJson(record['fields']))
          .toList();
      }
      else{return [];}
    }
    catch(e){
      rethrow;
    }
  }
}