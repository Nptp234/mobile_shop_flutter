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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          //img
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: 130,
              height: 150,

              child: Image.network(cart.imgUrl!, fit: BoxFit.contain,),
            ),
          ),
          
          //detail
          _detail(),
        ],
      ),
    );
  }

  Widget _detail(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        //name
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 150,
              child: Text(cart.productName!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),),
            ),
            IconButton(
              onPressed: (){

              }, 
              icon: const Icon(Icons.delete, color: Colors.red,)
            )
          ],
        ),

        //variant
        

        //price and amount
      ],
    );
  }

}