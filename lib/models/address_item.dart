import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/data/models/shipment.dart';
import 'package:mobile_shop_flutter/data/models/user.dart';
import 'package:mobile_shop_flutter/models/const.dart';
class AddressItem extends StatelessWidget{
  AddressItem({super.key, required this.shipment, required this.isSelected, required this.onSelect});
  Shipment shipment;
  final VoidCallback onSelect;
  final bool isSelected;

  final user = User();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        width: double.infinity,
        height: 200,
        padding: const EdgeInsets.all(3),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Expanded(
              flex: 0,
              child: Transform.scale(
                scale: 1.3,
                child: Checkbox(
                  activeColor: mainColor,
                  side: const BorderSide(color: Colors.grey, width: 2),
                  value: isSelected, 
                  onChanged: (value) => onSelect()
                ),
              ),
            ),
            const SizedBox(width: 10,),

            Expanded(flex: 2, child: _info(),)
          ],
        ),
      ),
    );
  }

  Widget _info(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(shipment.nameAddress!, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
            IconButton(
              onPressed: (){}, 
              icon: const Icon(Icons.edit)
            )
          ],
        ),

        Text(phoneFormated(user.phoneNumber!), style: const TextStyle(color: Colors.grey, fontSize: 17, fontWeight: FontWeight.normal),),
        const SizedBox(height: 7,),
        Text(shipment.address!, style: const TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.normal),),
      ],
    );
  }

}