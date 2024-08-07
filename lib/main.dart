import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/data/api/storage.dart';
import 'package:mobile_shop_flutter/models/const.dart';
import 'package:mobile_shop_flutter/views/first/signIn.dart';
import 'package:mobile_shop_flutter/views/second/3d_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await writeData();
  runApp(const MainApp());
}

writeData() async{
  await write();
  await writeUrl('userUrl', 'https://api.airtable.com/v0/appiDzAXS8n8Y4wpI/tblCjhy3ZoBu2p0np');
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
