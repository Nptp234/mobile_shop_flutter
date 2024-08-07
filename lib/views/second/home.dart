import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/models/bottom_menu.dart';
import 'package:mobile_shop_flutter/models/const.dart';

class HomePage extends StatefulWidget{

  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage>{


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
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 30),
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

                child: Image.asset('assets/logo_icon/arvarta.png', fit: BoxFit.cover,),
              ),
            ),
            Container(
              width: getMainWidth(context)/2,
              padding: EdgeInsets.only(left: 10),

              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text('Good Morning', style: TextStyle(fontSize: 17, color: Colors.black38, fontWeight: FontWeight.w500),),
                  Text('Admin Alex', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
                ],
              ),
            ),

            //notification and wishlist
            IconButton(
              onPressed: (){}, 
              icon: Icon(Icons.notifications)
            ),
            IconButton(
              onPressed: (){}, 
              icon: Icon(CupertinoIcons.heart_fill)
            ),
          ],
        ),
      )
    );
  }

}