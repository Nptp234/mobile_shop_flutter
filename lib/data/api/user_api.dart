import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_shop_flutter/data/api/storage.dart';

class UserAPI{

  Future<Map<dynamic, dynamic>> getData() async{
    try{
      String? key = await read();
      String? url = await readUrl('userUrl');

      final res = await http.get(Uri.parse(url!), headers: {'Authorization':'Bearer $key'});
      
      if(res.statusCode==200){ return jsonDecode(res.body); }
      else { throw Exception('Fail to load data!'); }
    }
    catch(e){
      rethrow;
    }
  }

  Future<String> signIn(String username, String password) async{
    try{
      final data = await getData();
      final records = data['records'];

      for(var record in records){
        var field = record['fields'];
        if(field['Username']==username && field['Password']==password){
          return '200';
        }
      }
      return 'Invalid username or password';
    }
    catch(e){
      rethrow;
    }
  }
}