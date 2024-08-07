import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

Future<void> write() async{
  await storage.write(key: 'apiKey', value: '');
}

Future<String?> read () async{
  return await storage.read(key: 'apiKey');
}

Future<void> writeUrl(String key, String url) async{
  await storage.write(key: key, value: url);
}

Future<String?> readUrl(String key) async{
  return await storage.read(key: key);
}