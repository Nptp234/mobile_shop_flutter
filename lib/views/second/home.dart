import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/data/models/user.dart';
import 'package:mobile_shop_flutter/models/const.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage>{

  final user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _header(context),
    );
  }

  PreferredSize _header(BuildContext context){
    return PreferredSize(
      preferredSize: Size.fromHeight(getMainHeight(context)/3), 
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 30),
        width: getMainWidth(context),
        
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            //img and name
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: 60,
                height: 60,
                padding: EdgeInsets.zero,

                child: Image.network(user.imgUrl!, fit: BoxFit.cover,),
              ),
            ),
            Container(
              width: getMainWidth(context)/2,
              padding: const EdgeInsets.only(left: 10),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Text('Good Morning', style: TextStyle(fontSize: 17, color: Colors.black38, fontWeight: FontWeight.w500),),
                  Text(user.username!, style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
                ],
              ),
            ),

            //notification and wishlist
            IconButton(
              onPressed: (){}, 
              icon: const Icon(Icons.notifications)
            ),
            IconButton(
              onPressed: (){}, 
              icon: const Icon(CupertinoIcons.heart_fill)
            ),
          ],
        ),
      )
    );
  }

}