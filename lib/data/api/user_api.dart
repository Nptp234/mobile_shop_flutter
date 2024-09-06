import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_shop_flutter/data/api/api.dart';
import 'package:mobile_shop_flutter/data/api/storage.dart';
import 'package:mobile_shop_flutter/data/api/telegram_bot.dart';
import 'package:mobile_shop_flutter/data/firebase/auth_firebase.dart';
import 'package:mobile_shop_flutter/data/firebase/storage_firebase.dart';
import 'package:mobile_shop_flutter/data/models/user.dart';
import 'package:mobile_shop_flutter/views/first/signIn.dart';
import 'package:path/path.dart';

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

  TelegramService telegramService = TelegramService();
  AuthFirebase authFirebase = AuthFirebase();
  StorageFirebase storageFirebase = StorageFirebase();

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

  Future<String> getImageUrl() async{
    try{
      String? key = await read();
      String? url = await readUrl('userUrl');
      final res = await http.get(
        Uri.parse('$url?filterByFormula={ID}="${user.id}"'),
        headers: {
          'Authorization': 'Bearer $key',
          'Content-Type': 'application/json'
        },
      );
      if(res.statusCode==200){
        Map<dynamic, dynamic> data = jsonDecode(res.body);
        String imgUrl = data['records'][0]['fields']['ProfileImg'][0]['url'];
        return imgUrl;
      }else{return '';}
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
          // auth firebase
          bool isAuth = await authFirebase.checkAuth(user.email!, user.password!);
          if(isAuth){return '200';}
          else{return 'fail auth';}
        }
      }
      return 'Invalid username or password';
    }
    catch(e){
      rethrow;
    }
  }

  // upload file to public url
  // get url and patch airtable api
  // delete file in public url
  Future<bool> updateImg(File img) async{
    try{

      //upload firebase
      String? imgUrl = await storageFirebase.uploadImage(img);
      //update airtable
      bool isUpA = await _updateAirtableImg(imgUrl!);
      //delete firebase
      bool isDe = await storageFirebase.deleteImg(imgUrl);

      return isUpA&&isDe;
    }
    catch(e){
      rethrow;
    }
  }

  Future<bool> _updateAirtableImg(String imgUrl) async{
    try{
      String? key = await read();
      String? url = await readUrl('userUrl');

      String recordId = await Api().getRecordId(key!, url!, user.id!);
      if(recordId==''){return false;}

      final body = {
        'records':[
          {
            "id": recordId,
            "fields": {
              "ProfileImg": [
                {"url": imgUrl}
              ]
            }
          }
        ]
      };

      final res = await http.patch(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $key',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body)
      );
      return res.statusCode==200;
    }
    catch(e){
      rethrow;
    }
  }

}