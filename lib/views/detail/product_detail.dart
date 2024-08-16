import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mobile_shop_flutter/data/api/product_api.dart';
import 'package:mobile_shop_flutter/data/models/product.dart';
import 'package:mobile_shop_flutter/models/const.dart';
import 'package:mobile_shop_flutter/models/variant_list.dart';
import 'package:mobile_shop_flutter/state_controller/variant_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProductDetailCustom extends StatefulWidget {
  ProductDetailCustom({super.key, required this.product});

  Product product;

  @override
  State<ProductDetailCustom> createState() => _ProductDetailCustom();
}

class _ProductDetailCustom extends State<ProductDetailCustom> {

  bool isLiked = false;

  ProductAPI productAPI = ProductAPI();
  Product product = Product();

  Future<Product> _getProduct() async{
    try{
      product = await productAPI.getVariantProduct(widget.product.id!);
      return product;
    }
    catch(e){
      rethrow;
    }
  }

  final variantTitleLst = VariantTitle();

  @override
  void initState() {
    super.initState();
    variantTitleLst.setProductID(widget.product.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      width: getMainWidth(context),
      height: 100,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: const BoxDecoration(
        // borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 9, offset: Offset(0, -1))
        ]
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          //price
          _price(),

          //space
          const SizedBox(width: 25,),

          //button
          _button(context),
        ],
      ),
    );
  }

  Widget _price(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Text('Total Price', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.normal),),
        Consumer<VariantProvider>(
          builder: (context, value, child) 
            => Text('${priceFormated('${int.parse(widget.product.price!)+value.extraPrice}')} VND', style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
        )
      ],
    );
  }

  Widget _button(BuildContext context){
    return GestureDetector(
      onTap: () {
        
      },

      child: Container(
        width: getMainWidth(context)/2,
        height: 60,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: mainColor,
        ),

        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Icon(Icons.shopping_bag, size: 30, color: Colors.white,),
            SizedBox(width: 20,),
            Text('Add to cart', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      // height: getMainHeight(context),
      width: getMainWidth(context),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //img
          _imgProduct(context),
          //title
          _title(context),
          //star and sold
          _starSold(),
          //description
          _description(),
          //amount
          _amount(context),
          //variant
          variantTitleLst,
        ],
      ),
    );
  }

  Widget _imgProduct(BuildContext context) {
    return Container(
        width: getMainWidth(context),
        margin: const EdgeInsets.only(bottom: 10),
        child: Center(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: Image.network(
                  widget.product.imgUrl!,
                  fit: BoxFit.contain,
                  width: getMainWidth(context),
                ),
              ),
              Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(180),
                        color: Colors.black38.withOpacity(0.3)),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 20,
                          color: Colors.white,
                        )),
                  )),
            ],
          ),
        ));
  }

  Widget _title(BuildContext context){
    return Container(
      width: getMainWidth(context),
      padding: const EdgeInsets.only(left: 20, right: 20),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          SizedBox(
            width: getMainWidth(context)/1.5,
            child: Text(widget.product.name!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),
          
          IconButton(
            onPressed: (){
              setState(() {
                isLiked=!isLiked;
              });
            }, 
            icon: isLiked?const Icon(CupertinoIcons.heart_fill, size: 30, color: Colors.red,):const Icon(CupertinoIcons.heart, size: 30,)
          ),
        ],
      ),
    );
  }

  Widget _starSold() {
    return Container(
      width: getMainWidth(context),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: const EdgeInsets.only(bottom: 15),

      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black26, width: 1))
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //star
          Container(
              padding: const EdgeInsets.all(1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RatingBarIndicator(
                    rating: double.parse(widget.product.starRating!) / 5, // Normalize value between 0 and 1
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.black,
                    ),
                    itemCount: 1,
                    itemSize: 30,
                    direction: Axis.horizontal,
                  ),
                  const SizedBox(width: 8), // Spacing between star and text
                  Text(
                    '${widget.product.starRating}/5',
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )),

          //sold
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.2)),
            child: Center(
              child: Text(
                '${widget.product.sold} sold',
                style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int maxLine = 3;
  String see = 'See all';

  Widget _description(){
    return Container(
      width: getMainWidth(context),
      padding: const EdgeInsets.only(left: 20, right: 20),
      margin: const EdgeInsets.only(top: 20),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text('Description', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          const SizedBox(height: 10,),
          SizedBox(
            width: getMainWidth(context),
            child: Text(
              widget.product.des!, 
              style: const TextStyle(
                color: Colors.black45, 
                fontSize: 17, 
                fontWeight: FontWeight.normal
              ),
              maxLines: maxLine,
            ),
          ),
          const SizedBox(height: 10,),
          GestureDetector(
            onTap: () {
              setState(() {
                if(see=='See all'){
                  maxLine = 50;
                  see = 'See less';
                }else{
                  maxLine = 3;
                  see = 'See all';
                }
              });
            },
            child: Container(
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
              child: Text(see, style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.normal),),
            ),
          )
        ],
      ),
    );
  }
  int amount = 1;

  Widget _amount(BuildContext context){
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, right: 20),
      margin: const EdgeInsets.only(top: 20),
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          const Text('Quantity', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(width: 20,),
          Container(
            width: getMainWidth(context)/3,
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
                  onPressed: (){
                    setState(() {
                      amount++;
                    });
                  }, 
                  icon: const Icon(Icons.add, size: 17, color: Colors.black,)
                ),
                Text('$amount', style: const TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),),
                IconButton(
                  onPressed: (){
                    setState(() {
                      if(amount>1){
                        amount--;
                      }
                    });
                  }, 
                  icon: const Icon(CupertinoIcons.minus, size: 17, color: Colors.black,)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
