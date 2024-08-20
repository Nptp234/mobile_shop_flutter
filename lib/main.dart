import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_shop_flutter/data/api/storage.dart';
import 'package:mobile_shop_flutter/models/const.dart';
import 'package:mobile_shop_flutter/state_controller/cart_provider.dart';
import 'package:mobile_shop_flutter/state_controller/variant_provider.dart';
import 'package:mobile_shop_flutter/views/first/signIn.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  await writeData();
  runApp(const MainApp());
}

String baseUrl = 'https://api.airtable.com/v0';

writeData() async{
  await write();
  await writeUrl('cohereUrl', 'https://api.cohere.ai/generate');
  await writeUrl('userUrl', '$baseUrl/${dotenv.env['BASE_ID']}/${dotenv.env['CUSTOMERS_TABLE']}');
  await writeUrl('bannerUrl', '$baseUrl/${dotenv.env['BASE_ID']}/${dotenv.env['BANNERS_TABLE']}');
  await writeUrl('categoryUrl', '$baseUrl/${dotenv.env['BASE_ID']}/${dotenv.env['CATEGORY_TABLE']}');
  await writeUrl('productUrl', '$baseUrl/${dotenv.env['BASE_ID']}/${dotenv.env['PRODUCT_TABLE']}');
  await writeUrl('combinationtUrl', '$baseUrl/${dotenv.env['BASE_ID']}/${dotenv.env['COMBINATION_TABLE']}');
  await writeUrl('stockUrl', '$baseUrl/${dotenv.env['BASE_ID']}/${dotenv.env['STOCK_TABLE']}');
  await writeUrl('cartUrl', '$baseUrl/${dotenv.env['BASE_ID']}/${dotenv.env['CART_TABLE']}');
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => VariantProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: const SignIn()
      ),
    );
  }
}
