import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_shop_flutter/data/api/storage.dart';
import 'package:mobile_shop_flutter/models/const.dart';
import 'package:mobile_shop_flutter/views/first/signIn.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  await writeData();
  runApp(const MainApp());
}

writeData() async{
  await write();
  await writeUrl('userUrl', 'https://api.airtable.com/v0/${dotenv.env['BASE_ID']}/${dotenv.env['CUSTOMERS_TABLE']}');
  await writeUrl('bannerUrl', 'https://api.airtable.com/v0/${dotenv.env['BASE_ID']}/${dotenv.env['BANNERS_TABLE']}');
  await writeUrl('categoryUrl', 'https://api.airtable.com/v0/${dotenv.env['BASE_ID']}/${dotenv.env['CATEGORY_TABLE']}');
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: tempColor),
        useMaterial3: true,
      ),
      home: SignIn()
    );
  }
}
