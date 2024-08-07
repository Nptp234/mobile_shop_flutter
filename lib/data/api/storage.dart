import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

Future<void> write() async{
  await storage.write(key: 'apiKey', value: 'patqJUhGnCLrwuGCL.8440a46b0c491a48239219253f66e6ef7eba2fa056edf8ba873f3480c40488df');
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