import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:mobile_shop_flutter/data/models/product.dart';
import 'package:mobile_shop_flutter/models/const.dart';
import 'package:mobile_shop_flutter/views/detail/product_detail.dart';
// import 'package:mobile_shop_flutter/models/const.dart';

// ignore: must_be_immutable
class ProductItem extends StatefulWidget {
  ProductItem({super.key, required this.product});

  Product product;

  @override
  State<ProductItem> createState() => _ProductItem();
}

class _ProductItem extends State<ProductItem> {
  // final double _height = 650;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailCustom(
                      product: widget.product,
                    )));
      },
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // border: Border.all(color: Colors.black26, width: 1),
            color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //image
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Center(
                child: Image.network(
                  widget.product.imgUrl!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            //name
            Text(
              widget.product.name!,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),

            //star and sold
            _starSold(),
            const SizedBox(
              height: 20,
            ),

            //price
            Text(
              '${priceFormated(widget.product.price!)} VND',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _starSold() {
    return Row(
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
                  itemSize: 25,
                  direction: Axis.horizontal,
                ),
                const SizedBox(width: 8), // Spacing between star and text
                Text(
                  '${widget.product.starRating}/5',
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
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
                  fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}
