import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/data/api/product_api.dart';
import 'package:mobile_shop_flutter/data/models/product.dart';
import 'package:mobile_shop_flutter/data/models/user.dart';
import 'package:mobile_shop_flutter/models/const.dart';
import 'package:mobile_shop_flutter/models/drawner.dart';
import 'package:mobile_shop_flutter/models/list_category.dart';
import 'package:mobile_shop_flutter/models/product_item.dart';
import 'package:mobile_shop_flutter/models/slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  
  final user = User();
  ProductListModel productListModel = ProductListModel();
  ProductAPI productAPI = ProductAPI();
  
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
                Container(
                  width: getMainWidth(context),
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  padding: const EdgeInsets.all(5),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.normal, color: Colors.grey),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black54,
                          size: 25,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.image_search,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1))),
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
            const CategoryList(),

            //all product
            _itemList(context, 'All Product'),
          ],
        ),
      ),
    );
  }

  // Widget _categoryLst() {
  //   return 
  // }

  Widget _slider() {
    return Container(
      width: getMainWidth(context),
      margin: const EdgeInsets.all(15),
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
