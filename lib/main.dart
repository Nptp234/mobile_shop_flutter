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

String baseUrl = 'https://api.airtable.com/v0';

writeData() async{
  await write();
  await writeUrl('userUrl', '$baseUrl/${dotenv.env['BASE_ID']}/${dotenv.env['CUSTOMERS_TABLE']}');
  await writeUrl('bannerUrl', '$baseUrl/${dotenv.env['BASE_ID']}/${dotenv.env['BANNERS_TABLE']}');
  await writeUrl('categoryUrl', '$baseUrl/${dotenv.env['BASE_ID']}/${dotenv.env['CATEGORY_TABLE']}');
  await writeUrl('productUrl', '$baseUrl/${dotenv.env['BASE_ID']}/${dotenv.env['PRODUCT_TABLE']}');
  await writeUrl('combinationtUrl', '$baseUrl/${dotenv.env['BASE_ID']}/${dotenv.env['COMBINATION_TABLE']}');
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: SignIn()
    );
  }
}
