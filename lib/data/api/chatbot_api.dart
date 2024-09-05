import 'dart:convert';
import 'dart:developer';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_shop_flutter/data/api/api.dart';
import 'package:mobile_shop_flutter/data/api/storage.dart';

class ChatbotApi {
  final api = Api();

 Future<String> sendMessCohere(String mess) async{
    try{
      final body = jsonEncode({
          "max_tokens": 1000,
          "model": "command-xlarge-nightly",
          "n": 1,
          "temperature": 1,
          "prompt": mess,
          "top_p": 1,
          "frequency_penalty": 0,
          "presence_penalty": 0,
          "version": "2022-12-06"
        });

      final response = await api.headerChatCohere(body);

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

 Future<String> requestGemini(String mess) async{
    try{ 
      final model = await api.headerChatGemini();
      final prompt = mess;
      final res = await model.generateContent([Content.text(prompt)]);
      return res.text!;
    }
    catch(e){
      rethrow;
    }
 }

}