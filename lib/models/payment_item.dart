import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/data/models/payment.dart';
import 'package:mobile_shop_flutter/models/const.dart';

class PaymentItem extends StatelessWidget{
  PaymentItem({super.key, required this.payment, required this.isSelected, required this.onSelect});
  Payment payment;
  final VoidCallback onSelect;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        width: double.infinity,
        height: 50,
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
        margin: const EdgeInsets.only(bottom: 20),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 50,
                height: 50,
                child: Image.network(payment.img!, fit: BoxFit.cover,),
              ),
            ),
            Text(payment.method!, style: const TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),),
            Transform.scale(
              scale: 1.3,
              child: Checkbox(
                activeColor: mainColor,
                side: const BorderSide(color: Colors.grey, width: 2),
                value: isSelected, 
                onChanged: (value) => onSelect(),
              ),
            )
          ],
        ),
      ),
    );
  }

}