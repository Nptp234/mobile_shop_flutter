import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

Future<void> write() async{
  await storage.write(key: 'apiKey', value: dotenv.env['API_KEY']);
  await storage.write(key: 'cohereKey', value: dotenv.env['COHERE_KEY']);
  await storage.write(key: 'geminiKey', value: dotenv.env['GEMINI_KEY']);
  await storage.write(key: 'stripeKey', value: dotenv.env['STRIPE_KEY']);
  await storage.write(key: 'stripePubKey', value: dotenv.env['STRIPE_PUB_KEY']);
}

Future<String?> read () async{
  return await storage.read(key: 'apiKey');
}

Future<String?> readCohere () async{
  return await storage.read(key: 'cohereKey');
}

Future<String?> readGemini () async{
  return await storage.read(key: 'geminiKey');
}

Future<String?> readStripe () async{
  return await storage.read(key: 'stripeKey');
}

Future<String?> readStripePub () async{
  return await storage.read(key: 'stripePubKey');
}

Future<void> writeUrl(String key, String url) async{
  await storage.write(key: key, value: url);
}

Future<String?> readUrl(String key) async{
  return await storage.read(key: key);
}