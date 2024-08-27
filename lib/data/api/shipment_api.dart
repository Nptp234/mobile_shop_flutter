import 'dart:convert';

import 'package:mobile_shop_flutter/data/api/api.dart';
import 'package:mobile_shop_flutter/data/api/storage.dart';
import 'package:mobile_shop_flutter/data/models/shipment.dart';
import 'package:http/http.dart' as http;

class ShipmentApi {
  final api = Api();

  Future<Map<dynamic, dynamic>> _getList() async{
    try{
      String? key = await read();
      String? url = await readUrl('shipmentUrl');

      final res = await http.get(
        Uri.parse(url!),
        headers: {
          'Authorization': 'Bearer $key',
        }
      );

      if(res.statusCode==200){return jsonDecode(res.body);}
      else{return {};}
    }
    catch(e){
      rethrow;
    }
  }

  Future<List<Shipment>> getAddressUser(String id) async{
    try{
      final response = await _getList();
      List<Shipment> lst = [];
      for(var record in response['records']){
        final field = record['fields'];
        
        if(field['CustomerID'][0]==id){
          lst.add(Shipment.fromJson(field));
        }
      }
      return lst;
    }
    catch(e){
      rethrow;
    }
  }

  Future<bool> addShipment(Shipment shipment) async{
    try{
      String? key = await read();
      String? url = await readUrl('shipmentUrl');

      final body = {
        "records":[
            {
              "fields":{
                "Customers": shipment.userID,
                "AddressName": shipment.nameAddress,
                "CustomerAddress": shipment.address,
              }
            }
          ]
      };

      final res = await http.post(
        Uri.parse(url!),
        headers: {
          'Authorization': 'Bearer $key',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(body),
      );

      if(res.statusCode==200){return true;}
      else{return false;}
    }
    catch(e){
      rethrow;
    }
  }
}