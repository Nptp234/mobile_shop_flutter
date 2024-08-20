import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:mobile_shop_flutter/data/api/storage.dart';

class ChatbotApi {

  Future<http.Response> _header(String mess) async{
    try{
      String? key = await readCohere();
      String? url = await readUrl('cohereUrl');

      final response = await http.post(
        Uri.parse(url!),
        headers: {
          'Authorization': 'Bearer $key',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          "max_tokens": 60,
          "model": "command-xlarge-nightly",
          "n": 1,
          "temperature": 1,
          "prompt": mess,
          "top_p": 1,
          "frequency_penalty": 0,
          "presence_penalty": 0,
          "version": "2022-12-06"
        })
      );

      return response;
    }
    catch(e){
      rethrow;
    }
  }

 Future<String> sendMess(String mess) async{
    try{
      final response = await _header(mess);

      //get the result
      if(response.statusCode==200){
        final resBody = jsonDecode(response.body);
        log(resBody['text']);
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