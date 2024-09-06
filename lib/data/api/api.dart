
import 'dart:convert';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_shop_flutter/data/api/storage.dart';

class Api {
  //singleton
  Api._privateConstructor();
  static final Api _instance = Api._privateConstructor();
  factory Api() {return _instance;}
  //

  Future<http.Response> headerChatCohere(final body) async{
    try{
      String? key = await readCohere();
      String? url = await readUrl('cohereUrl');

      final response = await http.post(
        Uri.parse(url!),
        headers: {
          'Authorization': 'Bearer $key',
          'Content-Type': 'application/json'
        },
        body: body
      );

      return response;
    }
    catch(e){
      rethrow;
    }
  }

  Future<GenerativeModel> headerChatGemini() async{
    try{
      String? key = await readGemini();

      final model = GenerativeModel(
        model: 'gemini-1.5-flash', 
        apiKey: key!,
        // generationConfig: GenerationConfig(responseMimeType: 'application/json')
      );
      return model;
    }
    catch(e){
      rethrow;
    }
  }

  Future<String> getRecordId(String key, String url, String id) async{
    try{
      final res = await http.get(
        Uri.parse('$url?filterByFormula={ID}="$id"'),
        headers: {
          'Authorization': 'Bearer $key',
          'Content-Type': 'application/json'
        },
      );
      if(res.statusCode==200){
        final data = jsonDecode(res.body);
        if(data['records'].isNotEmpty){
          return data['records'][0]['id'];
        }else{return '';}
      }else {return '';}
    }
    catch(e){
      return '$e';
    }
  }
}