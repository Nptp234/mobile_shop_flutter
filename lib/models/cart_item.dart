import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/data/models/cart.dart';
import 'package:mobile_shop_flutter/models/const.dart';

class CartItem extends StatelessWidget{

  Cart cart;
  CartItem({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getMainWidth(context),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
        color: Colors.white,
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          //img
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: 70,
              height: 100,

              child: Image.network(cart.imgUrl!, fit: BoxFit.cover,),
            ),
          ),
          
          //another
        ],
      ),
    );
  }

}