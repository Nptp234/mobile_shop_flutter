import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_shop_flutter/data/api/storage.dart';
import 'package:mobile_shop_flutter/data/models/user.dart';
import 'package:mobile_shop_flutter/views/first/signIn.dart';
import 'package:mobile_shop_flutter/views/first/waiting.dart';

class UserAPI{

  //Singleton connection
  UserAPI._privateConstructor();

  // Static instance
  static final UserAPI _instance = UserAPI._privateConstructor();

  // Factory constructor to return the static instance
  factory UserAPI() {
    return _instance;
  }

  final user = User();

  _setCurrentuserFromJson(Map<dynamic, dynamic> data){
    user.fromJson(data);
  }

  logOut(BuildContext context){
    user.clear();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignIn()));
  }

  setFirst(){
    user.clear();
  }

  Future<Map<dynamic, dynamic>> getData() async{
    try{
      String? key = await read();
      String? url = await readUrl('userUrl');

      final res = await http.get(Uri.parse(url!), headers: {'Authorization':'Bearer $key'});
      
      if(res.statusCode==200){ return jsonDecode(res.body); }
      else { return {}; }
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
          _setCurrentuserFromJson(field);
          return '200';
        }
      }
      return 'Invalid username or password';
    }
    catch(e){
      rethrow;
    }
  }

  Future<void> updateImg() async{
    try{

    }
    catch(e){
      rethrow;
    }
  }
}