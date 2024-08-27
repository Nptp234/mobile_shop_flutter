import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/data/models/shipment.dart';
import 'package:mobile_shop_flutter/data/models/user.dart';
import 'package:mobile_shop_flutter/models/const.dart';

class AddressItem extends StatefulWidget{
  AddressItem({super.key, required this.shipment});
  Shipment shipment;

  @override
  State<AddressItem> createState() => _AddressItem();
}

class _AddressItem extends State<AddressItem>{

  final user = User();
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isCheck=!isCheck;
        });
      },
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
                  side: BorderSide(color: Colors.grey, width: 2),
                  value: isCheck, 
                  onChanged: (value) => setState(() {
                    isCheck = value!;
                  })
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
            Text(widget.shipment.nameAddress!, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
            IconButton(
              onPressed: (){}, 
              icon: Icon(Icons.edit)
            )
          ],
        ),

        Text(phoneFormated(user.phoneNumber!), style: const TextStyle(color: Colors.grey, fontSize: 17, fontWeight: FontWeight.normal),),
        const SizedBox(height: 7,),
        Text(widget.shipment.address!, style: const TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.normal),),
      ],
    );
  }

}