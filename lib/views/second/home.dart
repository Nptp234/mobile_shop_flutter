import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/data/api/category_api.dart';
import 'package:mobile_shop_flutter/data/api/product_api.dart';
import 'package:mobile_shop_flutter/data/models/category.dart';
import 'package:mobile_shop_flutter/data/models/product.dart';
import 'package:mobile_shop_flutter/data/models/user.dart';
import 'package:mobile_shop_flutter/models/const.dart';
import 'package:mobile_shop_flutter/models/drawner.dart';
import 'package:mobile_shop_flutter/models/list_category.dart';
import 'package:mobile_shop_flutter/models/product_item.dart';
import 'package:mobile_shop_flutter/models/slider.dart';
import 'package:mobile_shop_flutter/views/second/search.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  
  final user = User();
  ProductListModel productListModel = ProductListModel();
  ProductAPI productAPI = ProductAPI();
  final categoryList = CategoryListModel();
  CategoryAPI categoryAPI = CategoryAPI();
  
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<List<Product>> _getProductAll() async {
    List<Product> lst = await productAPI.getAll();
    return lst;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: _header(context),
      body: _body(),
      drawer: const DrawnerCustom(),
    );
  }

  PreferredSize _header(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(getMainHeight(context) / 5),
        child: Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.only(top: 30),
            width: getMainWidth(context),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //drawner
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        IconButton(
                          onPressed: (){
                            if(scaffoldKey.currentState!.isDrawerOpen){
                              scaffoldKey.currentState!.closeDrawer();
                              //close drawer, if drawer is open
                            }else{
                              scaffoldKey.currentState!.openDrawer();
                              //open drawer, if drawer is closed
                            }
                          }, 
                          icon: const Icon(Icons.menu)
                        ),

                        //img and name
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            width: 50,
                            height: 50,
                            padding: EdgeInsets.zero,
                            child: Image.network(
                              user.imgUrl!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          // width: 100,
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Good Morning',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                user.username!,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    //notification and wishlist
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications)),
                  ],
                ),

                //search bar
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchPage()));
                  },
                  child: Container(
                    width: getMainWidth(context),
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 30),
                    padding: const EdgeInsets.all(15),

                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5, color: Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(20)
                    ),

                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          
                          children: [
                            Icon(Icons.search, color: Colors.black54, size: 25,),
                            SizedBox(width: 10,),
                            Text('Search...', style: TextStyle(fontWeight: FontWeight.normal, color: Colors.grey, fontSize: 17),)
                          ],
                        )

                      ],
                    )
                  ),
                )
              ],
            )));
  }

  Widget _body() {
    return Container(
      width: getMainWidth(context),
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _slider(),

            //category list
            _categoryLst(context),

            //all product
            _itemList(context, 'All Product'),
          ],
        ),
      ),
    );
  }

  Widget _categoryLst(BuildContext context) {
    return Container(
      width: getMainWidth(context),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 20),
      
      decoration: const BoxDecoration(
        color: Colors.white
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          //title
          const Text('Shop with category', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
          const SizedBox(height: 20,),

          //lst
          SizedBox(
            width: double.infinity,
            height: 150,
            child: _cateLst(),
          )
        ],
      ),
    );
  }

  Widget _cateLst(){
    return FutureBuilder<List<Category>>(
        future: categoryAPI.setCategoryList(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          else if(!snapshot.hasData){
            WidgetsBinding.instance.addPostFrameCallback((_) {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Data is null!',
              );
            });

            return const SizedBox();
          }
          else{
            return Center(
              child: GridView.builder(
                itemCount: snapshot.data!.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 0.0,
                  crossAxisSpacing: 0.0,
                  childAspectRatio: 1.5,
                ), 
                itemBuilder: (context, index){
                  return SizedBox(
                    width: 150,

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Container(
                          width: 60, 
                          height: 60, 
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 10),
                          
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            // color: secondaryColor.withOpacity(0.5),
                            color: Colors.transparent
                          ),

                          child: Image.network(snapshot.data![index].iconUrl!, fit: BoxFit.contain,),
                        ),
                        Text(snapshot.data![index].name!, style: const TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.normal),)
                      ],
                    ),
                  );
                }
              ),
            );
          }
        },
      );
  }

  Widget _slider() {
    return Container(
      width: getMainWidth(context),
      margin: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 25),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Special Offer',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'See All',
                  style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              )
            ],
          ),

          //slider
          const SliderBanner(),
        ],
      ),
    );
  }

  Widget _itemList(BuildContext context, String title) {
    return Container(
      width: getMainWidth(context),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 20),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title and "See All" option
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'See All',
                  style: TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),

          // List of products
          FutureBuilder<List<Product>>(
            future: _getProductAll(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'No products available',
                    style: TextStyle(color: Colors.black45),
                  ),
                );
              } else {
                // Using SizedBox to constrain the height
                return SizedBox(
                  width: getMainWidth(context),
                  height: 1000,

                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length>=20?20:snapshot.data!.length,
                    physics: const ScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 0.5,
                      crossAxisSpacing: 0.5,
                      childAspectRatio: 2.0,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 25, top: 20),
                        child: ProductItem(
                          product: snapshot.data![index],
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

}
