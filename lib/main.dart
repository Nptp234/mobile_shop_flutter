import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/models/const.dart';
import 'package:mobile_shop_flutter/views/first/signIn.dart';
import 'package:mobile_shop_flutter/views/second/3d_page.dart';

void main() {
  runApp(const MainApp());
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
