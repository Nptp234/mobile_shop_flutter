import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/data/api/product_api.dart';
import 'package:mobile_shop_flutter/data/models/product.dart';
import 'package:mobile_shop_flutter/data/sqlite/wishlist_sqlite.dart';
import 'package:mobile_shop_flutter/models/const.dart';
import 'package:mobile_shop_flutter/models/product_item.dart';

class WishlistPage extends StatefulWidget{
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPage();
}

class _WishlistPage extends State<WishlistPage>{

  TextEditingController searchController = TextEditingController();
  WishlistSqlite wishlistSqlite = WishlistSqlite();
  ProductAPI productAPI = ProductAPI();

  Future<List<Product>> _getList() async{
    List<String> lst = await wishlistSqlite.getList();
    List<Product> pros = await productAPI.getAll();
    if(lst.isNotEmpty){return pros.where((p) => lst.contains(p.id)).toList();}
    else{return [];}
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
            centerTitle: 'My Wishlist',
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
    return FutureBuilder<List<Product>>(
      future: _getList(),
      builder: (context, snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }
        else if(snapshot.hasError){
          return Center(child: Text('${snapshot.error}'),);
        }
        else if(snapshot.data!.length==0){
          return Center();
        }
        else{
          return Container(
            width: getMainWidth(context),
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 3, right: 3),

            child: GridView.builder(
              itemCount: snapshot.data!.length,
              scrollDirection: Axis.vertical,
              physics: const ScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.4,
                mainAxisSpacing: 0.5,
                crossAxisSpacing: 0.5
              ), 
              itemBuilder: (context, index){
                return ProductItem(product: snapshot.data![index]);
              }
            ),
          );
        }
      },
    );
  }

}