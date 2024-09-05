import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_shop_flutter/data/api/storage.dart';
import 'package:mobile_shop_flutter/data/api/telegram_bot.dart';
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

  // upload file to public url
  // get url and patch airtable api
  // delete file in public url
  Future<bool> updateImg(File img) async{
    try{
      String? key = await read();
      String? url = await readUrl('userUrl');

      String imgUrl = await telegramService.uploadAndGet(img);

      return true;
    }
    catch(e){
      rethrow;
    }
  }

  // Future<bool> updateImg(File img) async{
  //   try{
  //     String? key = await read();
  //     String? url = await readUrl('userUrl');

  //     var request = http.MultipartRequest('POST', Uri.parse(url!));
  //     request.headers['Authorization'] = 'Bearer $key';

  //     //add file
  //     request.files.add(
  //       await http.MultipartFile.fromPath(
  //         'ProfileImg', 
  //         img.path, 
  //         filename: basename(img.path),
  //       )
  //     );
  //     var res = await request.send();
  //     if(res.statusCode==200){
  //       //get url
  //       final responseBody = await res.stream.bytesToString();
  //       final responseData = jsonDecode(responseBody);
  //       user.imgUrl = responseData['records'][0]['fields']['ProfileImg'][0]['url'];
  //       user.imgName = responseData['records'][0]['fields']['ProfileImg'][0]['filename'];

  //       final attachmentID = responseData['records'][0]['fields']['ProfileImg'][0]['id'];
  //       final body = {
  //         'records':[
  //           {
  //             "id": "recuFLzC9m5cB0loF", // Replace with the actual record ID
  //             "fields": {
  //               "ID": user.id,
  //               "ProfileImg": [
  //                 {"id": attachmentID}
  //               ]
  //             }
  //           }
  //         ]
  //       };

  //       //final update
  //       final updateRes = await http.patch(
  //         Uri.parse(url),
  //         headers: {
  //           'Authorization': 'Bearer $key',
  //           'Content-Type': 'application/json'
  //         },
  //         body: jsonEncode(body),
  //       );
  //       if (updateRes.statusCode != 200) {
  //         return true;
  //       }else {return false;}

  //     }else {return false;}

  //   }
  //   catch(e){
  //     rethrow;
  //   }
  // }
}