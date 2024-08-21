import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:mobile_shop_flutter/data/api/api.dart';
import 'package:mobile_shop_flutter/data/api/storage.dart';

class ChatbotApi {
  final api = Api();

 Future<String> sendMess(String mess) async{
    try{
      final response = await api.headerChat(mess);

      //get the result
      if(response.statusCode==200){
        final resBody = jsonDecode(response.body);
        // log(resBody['text']);
        return resBody['text'];
      }else{
        log('failed!');
        return "failed!";
      }
    }
    catch(e){
      rethrow;
    }
 }

}