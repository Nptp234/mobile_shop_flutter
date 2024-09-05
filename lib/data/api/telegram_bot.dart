import 'dart:convert';
import 'dart:io';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class TelegramService{
  final String? botToken = dotenv.env['TELEGRAM_BOT'];
  final String? chatID = dotenv.env['CHAT_ID'];
  String get baseUrl => 'https://api.telegram.org/bot$botToken';

  Future<bool> sendImage(File file) async{
    try{
      final url = '$baseUrl/sendPhoto';
      final request = http.MultipartRequest('POST', Uri.parse(url))
        ..fields['chat_id'] = chatID!
        ..fields['caption'] = ''
        ..files.add(await http.MultipartFile.fromPath('photo', file.path));
      
      final response = await request.send();

      // Read the response body for error details
      // final responseBody = await response.stream.bytesToString();
      // log('Failed to send image. Status code: ${response.statusCode}');
      // log('Response body: $responseBody');
      
      if(response.statusCode==200){return true;}
      else {return false;}
    }
    catch(e){
      rethrow;
    }
  }

  Future<String> getImgUrl() async{
    try{
      final url = '$baseUrl/getUpdates';
      final response = await http.get(Uri.parse(url));
      log(jsonDecode(response.body));
      return '${jsonDecode(response.body)}';
    }
    catch(e){
      rethrow;
    }
  }

  Future<String> uploadAndGet(File img) async{
    try{
      bool isUp = await sendImage(img);
      if(isUp){
        String url = await getImgUrl();
        return url;
      }else {return '';}
    }
    catch(e){
      rethrow;
    }
  }
}