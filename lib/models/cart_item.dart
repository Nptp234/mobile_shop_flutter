import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/data/api/cart_api.dart';
import 'package:mobile_shop_flutter/data/models/cart.dart';
import 'package:mobile_shop_flutter/models/const.dart';
import 'package:mobile_shop_flutter/state_controller/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class CartItem extends StatefulWidget{
  final Cart cart;
  CartProvider cartProvider;
  CartItem({super.key, required this.cart, required this.cartProvider});

  @override
  State<CartItem> createState() => _CartItem();
}

class _CartItem extends State<CartItem>{

  @override
  void initState() {
    super.initState();
  }

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

              child: Image.network(widget.cart.imgUrl!, fit: BoxFit.contain,),
            ),
          ),
          
          //detail
          _detail(context),
        ],
      ),
    );
  }

  Widget _detail(BuildContext context){
    return ChangeNotifierProvider.value(
      value: widget.cartProvider,
        child: Consumer<CartProvider>(
          builder: (context, value, child) {
            return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              //name
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 160,
                    child: Text(widget.cart.productName!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),),
                  ),
                  IconButton(
                    onPressed: (){

                    }, 
                    icon: const Icon(Icons.delete, color: Colors.red,)
                  )
                ],
              ),
              const SizedBox(height: 15,),

              //variant
              SizedBox(
                height: 50,
                child: ListView.builder(
                  itemCount: widget.cart.variantValues.length,
                  scrollDirection: Axis.horizontal,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    String variantName = widget.cart.variantValues.keys.elementAt(index);
                    String values = widget.cart.variantValues[variantName]!;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Text('$variantName:', style: const TextStyle(fontSize: 17, color: Colors.grey, fontWeight: FontWeight.bold),),
                        const SizedBox(width: 7,),
                        variantName=='Color'?
                        Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(180),
                            border: Border.all(color: Colors.grey, width: 2),
                            color: Color(int.parse(values))
                          ),
                        ):
                        Text(values, style: const TextStyle(fontSize: 17, color: Colors.grey, fontWeight: FontWeight.bold),),
                        const SizedBox(width: 7,),
                        Container(
                          width: 2,
                          height: 30,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 10,),
                      ],
                    );
                  }
                ),
              ),
              const SizedBox(height: 20,),

              //price and amount
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                  
                children: [
                  //amount
                  _amount(context),
                  const SizedBox(height: 20,),
                  //price
                  Text('${value.price!=0?priceFormated('${widget.cartProvider.price}'):priceFormated('${widget.cart.totalPrice}')} VND', style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),)
                ],
              ),
            ],
          );
        },
      )
    );
  }

  Widget _amount(BuildContext context){
    return ChangeNotifierProvider.value(
      value: widget.cartProvider,
        child: Consumer<CartProvider>(
          builder: (context, value, child) {
            return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Container(
                width: 140,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 2, color: Colors.grey.withOpacity(0.5)),
                  color: Colors.grey[100],
                ),

                child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        IconButton(
                          onPressed: () {
                            value.addAmount();
                          }, 
                          icon: const Icon(Icons.add, size: 17, color: Colors.black,)
                        ),
                        Text('${value.amount!=0?value.amount:widget.cart.amount}', style: const TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),),
                        IconButton(
                          onPressed: () {
                            if(value.amount>1) {
                              value.decrease();
                            }
                          }, 
                          icon: const Icon(CupertinoIcons.minus, size: 17, color: Colors.black,)
                        ),
                      ],
                    )
              )
            ]
          );
        },
      )
    );
  }

}