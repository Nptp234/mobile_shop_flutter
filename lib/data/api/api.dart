import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_shop_flutter/data/api/storage.dart';

class Api {
  //singleton
  Api._privateConstructor();
  static final Api _instance = Api._privateConstructor();
  factory Api() {return _instance;}
  //

  Future<http.Response> headerChat(String mess) async{
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
          "max_tokens": 1000,
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
}