import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/models/const.dart';

class CartCheckout extends StatefulWidget{
  const CartCheckout({super.key});

  @override
  State<CartCheckout> createState() => _CartCheckout();
}

class _CartCheckout extends State<CartCheckout>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _header(context),
    );
  }

  PreferredSize _header(BuildContext context){
    return PreferredSize(
      preferredSize: const Size.fromHeight(100), 
      child: Container(
        width: getMainWidth(context),
        height: double.infinity,
        padding: const EdgeInsets.all(10),
        
      )
    );
  }

}