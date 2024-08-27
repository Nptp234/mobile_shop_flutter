import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/data/api/shipment_api.dart';
import 'package:mobile_shop_flutter/data/models/shipment.dart';
import 'package:mobile_shop_flutter/data/models/user.dart';
import 'package:mobile_shop_flutter/models/address_item.dart';
import 'package:mobile_shop_flutter/models/const.dart';

class CartCheckout extends StatefulWidget{
  const CartCheckout({super.key});

  @override
  State<CartCheckout> createState() => _CartCheckout();
}

class _CartCheckout extends State<CartCheckout>{

  final user = User();
  ShipmentApi shipmentApi = ShipmentApi();

  Future<List<Shipment>> _getList() async{
    try{
      List<Shipment> lst = await shipmentApi.getAddressUser(user.id!);
      return lst;
    }
    catch(e){
      rethrow;
    }
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
    );
  }

  Widget _body(BuildContext context){
    return Container(
      width: getMainWidth(context),
      padding: const EdgeInsets.only(left: 20, right: 20),
      decoration: const BoxDecoration(color: Colors.white),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          _total('3', '10000000'),
          _address(),
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
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text('Your shipment address', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
          const SizedBox(height: 20,),
          FutureBuilder<List<Shipment>>(
            future: _getList(),
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
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) { 
                    return AddressItem(shipment: snapshot.data![index],);
                  },
                );
              }
            },
          )
        ],
      ),
    );
  }

  // Widget _addressItem(Shipment shipment, bool isCheck){
  //   return Container(
  //     width: double.infinity,
  //     height: 200,
  //     padding: const EdgeInsets.all(10),
  //     decoration: BoxDecoration(
  //       border: Border.all(color: Colors.grey, width: 1),
  //       borderRadius: BorderRadius.circular(20),
  //       color: Colors.white
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.start,

  //       children: [
  //         Checkbox(
  //           value: isCheck, 
  //           onChanged: (value) => setState(() {
  //             isCheck = value!;
  //           })
  //         ),
  //       ],
  //     ),
  //   );
  // }

}