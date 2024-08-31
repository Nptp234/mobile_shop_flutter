import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/data/api/payment_api.dart';
import 'package:mobile_shop_flutter/data/api/shipment_api.dart';
import 'package:mobile_shop_flutter/data/models/cart.dart';
import 'package:mobile_shop_flutter/data/models/payment.dart';
import 'package:mobile_shop_flutter/data/models/shipment.dart';
import 'package:mobile_shop_flutter/data/models/user.dart';
import 'package:mobile_shop_flutter/models/address_item.dart';
import 'package:mobile_shop_flutter/models/const.dart';
import 'package:mobile_shop_flutter/models/payment_item.dart';
import 'package:mobile_shop_flutter/views/cart/my_order.dart';
import 'package:mobile_shop_flutter/views/cart/payment.dart';

class CartCheckout extends StatefulWidget{
  const CartCheckout({super.key});

  @override
  State<CartCheckout> createState() => _CartCheckout();
}

class _CartCheckout extends State<CartCheckout>{

  final user = User();
  ShipmentApi shipmentApi = ShipmentApi();
  PaymentApi paymentApi = PaymentApi();

  final myOrder = MyOrder();
  
  int? selectedPayment;
  void onSelectPayment(int index){
    setState(() {
      selectedPayment=index;
    });
  }

  int? selectedAddress;
  void onSelectedAddress(int index){
    setState(() {
      selectedAddress=index;
    });
  }

  Future<List<Shipment>> _getListAddress() async{
    try{
      List<Shipment> lst = await shipmentApi.getAddressUser(user.id!);
      return lst;
    }
    catch(e){
      rethrow;
    }
  }

  Future<List<Payment>> _getListPayment() async{
    try{
      List<Payment> lst = await paymentApi.getAll();
      return lst;
    }
    catch(e){
      rethrow;
    }
  }

  String sumPriceCart(List<Cart> lst){
    double sum = 0;
    for(var cart in lst){
      sum+=int.parse(cart.totalPrice!);
    }
    return '$sum';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerSub(context, 'Cart checkout'),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        child: _body(context),
      ),
      bottomNavigationBar: _footer(context),
    );
  }

  Widget _footer(BuildContext context){
    return Container(
      height: 100,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 30),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentPage()));
        },
        child: Container(
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.circular(20)
          ),
          child: const Center(child: Text('Pay Now', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),),
        ),
      )
    );
  }

  Widget _body(BuildContext context){
    return Container(
      width: getMainWidth(context),
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      decoration: const BoxDecoration(color: Colors.white),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          _total('${myOrder.lstCarts.length}', sumPriceCart(myOrder.lstCart)),
          _address(),
          _paymentMethod()
        ],
      ),
    );
  }

  Widget _total(String amount, String total){
    return SizedBox(
      width: double.infinity,
      height: 100,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('You have $amount item in your cart', style: const TextStyle(fontSize: 17, color: Colors.black),),
              const Text('Total', style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),)
            ],
          ),
          const SizedBox(height: 10,),
          SizedBox(
            width: double.infinity,
            child: Text('${priceFormated(total)} VND', style: TextStyle(fontSize: 20, color: mainColor, fontWeight: FontWeight.bold), textAlign: TextAlign.end,),
          )
        ],
      ),
    );
  }

  Widget _address(){
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text('Your shipment address', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
          const SizedBox(height: 20,),
          FutureBuilder<List<Shipment>>(
            future: _getListAddress(),
            builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator(),);
              }
              else if(!snapshot.hasData){
                return const Center(child: Text('Data null!'),);
              }else if(snapshot.hasError){
                return Center(child: Text('${snapshot.error}'),);
              }
              else{
                return SizedBox(
                  // width: 350,
                  // height: 500,
                  child: Center(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      scrollDirection: Axis.vertical,
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return AddressItem(shipment: snapshot.data![index], isSelected: selectedAddress==index, onSelect: () => onSelectedAddress(index));
                      },
                    ),
                  )
                );
              }
            },
          )
        ],
      ),
    );
  }

  Widget _paymentMethod(){
    return SizedBox(
      width: double.infinity,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text('Your payment method', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
          const SizedBox(height: 20,),

          FutureBuilder<List<Payment>>(
            future: _getListPayment(),
            builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator(),);
              }
              else if(!snapshot.hasData){
                return const Center(child: Text('Data null!'),);
              }else if(snapshot.hasError){
                return Center(child: Text('${snapshot.error}'),);
              }
              else{
                return SizedBox(
                  // height: 500,
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    scrollDirection: Axis.vertical,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return PaymentItem(payment: snapshot.data![index], isSelected: selectedPayment==index, onSelect: () => onSelectPayment(index));
                    },
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}