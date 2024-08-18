import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:flutter/material.dart';

class MyOrder extends StatefulWidget{
  const MyOrder({super.key});

  @override 
  State<MyOrder> createState() => _MyOrder();
}

class _MyOrder extends State<MyOrder>{

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _header(context),
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
            onChanged: (p0) {
              
            },
            searchTextEditingController: searchController,
            horizontalPadding: 0,
          ),
        )
      )
    );
  }

}