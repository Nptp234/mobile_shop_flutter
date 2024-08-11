import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:mobile_shop_flutter/data/models/product.dart';
import 'package:mobile_shop_flutter/models/const.dart';

// ignore: must_be_immutable
class ProductItem extends StatefulWidget{
  ProductItem({super.key, required this.product});
  
  Product product; 

  @override
  State<ProductItem> createState() => _ProductItem();
}

class _ProductItem extends State<ProductItem>{
  final double _height = 650;
  double _value = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: _height,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // border: Border.all(color: Colors.black26, width: 1),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          //image
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: _height/4,

              child: Image.network(widget.product.imgUrl!, fit: BoxFit.cover,),
            ),
          ),
          const SizedBox(height: 20,),

          //name
          Text(widget.product.name!, style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
          const SizedBox(height: 20,),

          //star and sold
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              //star
              Container(
                padding: EdgeInsets.all(10),

                child: RatingStars(
                  value: _value,
                  onValueChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                  starBuilder: (index, color) => Icon(Icons.star, color: color,),
                  starCount: 1,
                  maxValueVisibility: true,
                  valueLabelVisibility: true,
                  animationDuration: const Duration(milliseconds: 500),
                ),
              ),

              //sold
              Container(
                padding: const EdgeInsets.all(5),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.5)
                ),

                child: Center(child: Text('2,000 sold', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15),),),
              ),
            ],
          ),
          const SizedBox(height: 20,),

          
          //price
          Text('${widget.product.price!} VND', style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
        ],
      ),

    );
  }

}