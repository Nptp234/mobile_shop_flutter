import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/data/api/product_api.dart';
import 'package:mobile_shop_flutter/data/models/product.dart';
import 'package:mobile_shop_flutter/models/const.dart';

class VariantList extends StatefulWidget{
  const VariantList({super.key, required this.variantName, required this.variantValue});

  final String variantName;
  final List<String> variantValue;

  @override
  State<VariantList> createState() => _variantList();
}

class _variantList extends State<VariantList>{
  int _selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.variantName,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 7),
        Container(
          width: double.infinity,
          height: 70,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 20),
          child: ListView.builder(
            itemCount: widget.variantValue.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              bool isSelected = index==_selectedIndex;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: Container(
                  width: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isSelected ? mainColor : Colors.white.withOpacity(0.5),
                    border: Border.all(
                      width: 2,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  child: widget.variantName == 'Color'
                      ? Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(int.parse(widget.variantValue[index])),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        )
                      : Center(
                          child: Text(
                            '${widget.variantValue[index]}GB',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: isSelected?FontWeight.bold:FontWeight.normal,
                              color: isSelected?Colors.white:Colors.black,
                            ),
                          ),
                        ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

}

class VariantTitle extends StatelessWidget{

  //Singleton connection
  VariantTitle._privateConstructor();

  // Static instance
  static final VariantTitle _instance = VariantTitle._privateConstructor();

  // Factory constructor to return the static instance
  factory VariantTitle() {
    return _instance;
  }
  
  late String productID;

  setProductID(String id){
    productID = id;
  }

  ProductAPI productAPI = ProductAPI();
  Product product = Product();
  
  Future<Product> _getProduct() async{
    try{
      product = await productAPI.getVariantProduct(productID);
      return product;
    }
    catch(e){
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Product>(
      future: _getProduct(), 
      builder: (context, snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }
        else{
          return Container(
            width: getMainWidth(context),
            height: 300,
            padding: const EdgeInsets.only(left: 20, right: 20),
            margin: const EdgeInsets.only(top: 20),

            child: ListView.builder(
              itemCount: snapshot.data!.variantValues!.length,
              scrollDirection: Axis.vertical,
              physics: const ScrollPhysics(),
              
              itemBuilder: (context, index){
                final variantName = snapshot.data!.variantValues!.keys.elementAt(index);
                final variantValue = snapshot.data!.variantValues![variantName]!;
                return VariantList(variantName: variantName, variantValue: variantValue,);
              }
            ),
          );
        }
      }
    );
  }

}