import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/data/api/cart_api.dart';
import 'package:mobile_shop_flutter/data/models/cart.dart';
import 'package:mobile_shop_flutter/models/cart_item.dart';
import 'package:mobile_shop_flutter/models/const.dart';
import 'package:mobile_shop_flutter/state_controller/cart_provider.dart';
import 'package:provider/provider.dart';

class MyOrder extends StatefulWidget{
  const MyOrder({super.key});

  @override 
  State<MyOrder> createState() => _MyOrder();
}

class _MyOrder extends State<MyOrder>{

  TextEditingController searchController = TextEditingController();
  CartAPI cartAPI = CartAPI();

  Future<List<Cart>> _getList() async{
    List<Cart> lst = await cartAPI.getList();
    return lst;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _header(context),
      body: _body(context),
    );
  }

  PreferredSize _header(BuildContext context){
    return PreferredSize(
      preferredSize: const Size.fromHeight(100), 
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10),

          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.5), offset: const Offset(0, 2), blurRadius: 3),
            ],
            color: Colors.white
          ),

          child: AnimationSearchBar(
            backIconColor: Colors.black,
            centerTitle: 'My Cart',
            centerTitleStyle: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 17, fontWeight: FontWeight.bold),
            textStyle: const TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
            onChanged: (p0) {
              
            },
            searchTextEditingController: searchController,
            horizontalPadding: 0,
          ),
        )
      )
    );
  }

  Widget _body(BuildContext context){
    return FutureBuilder<List<Cart>>(
      future: _getList(), 
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }
        else{
          return Consumer<CartProviderList>(
            builder: (context, value, child) {
              
              value.setListCartPro(snapshot.data!);

              return Container(
                width: getMainWidth(context),
                height: getMainHeight(context),
                padding: const EdgeInsets.all(10),

                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CartItem(cart: snapshot.data![index], cartProvider: value.cartPros[index],);
                  },
                ),
              );
            },
          );
        }
      }
    );
  }

}