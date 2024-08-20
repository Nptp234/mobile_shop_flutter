// import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/data/api/user_api.dart';
import 'package:mobile_shop_flutter/data/models/user.dart';
import 'package:mobile_shop_flutter/models/const.dart';
import 'package:mobile_shop_flutter/views/cart/my_order.dart';
import 'package:mobile_shop_flutter/views/first/signIn.dart';
// import 'package:mobile_shop_flutter/models/const.dart';
// import 'package:mobile_shop_flutter/models/list_settings.dart';
import 'package:mobile_shop_flutter/views/second/account_center.dart';
import 'package:mobile_shop_flutter/views/second/home.dart';
import 'package:mobile_shop_flutter/views/second/support.dart';
import 'package:mobile_shop_flutter/views/second/wishlist.dart';

class DrawnerCustom extends StatefulWidget {
  const DrawnerCustom({super.key});

  @override
  State<DrawnerCustom> createState() => _DrawnerCustomState();
}


class _DrawnerCustomState extends State<DrawnerCustom> {
  final user = User();
  bool isDrawerOpen = false;
  final userAPI = UserAPI();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        height: double.infinity,
        padding: const EdgeInsets.only(top: 50),

        child: _buildDrawerMenu(),
      ),
    );
  }

  Widget _buildDrawerMenu() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TitleMenuItem(
                title: 'Account Center',
                icon: Icons.person,
                gotoWidget: const AccountCenter(),
              ),
              _TitleMenuItem(
                title: 'My Orders',
                icon: Icons.shopping_bag,
                gotoWidget: const MyOrder(),
              ),
              _TitleMenuItem(
                title: 'Wishlist',
                icon: Icons.favorite,
                gotoWidget: const WishlistPage(),
              ),
              _TitleMenuItem(
                title: 'Support',
                icon: Icons.support_agent,
                gotoWidget: const SupportPage(),
              ),
            ],
          ),
        ),

        //
        Container(
          width: double.infinity,
          color: mainColor,

          child: _TitleMenuItem(
            title: 'Log out',
            icon: Icons.logout_outlined,
            gotoWidget: const SignIn(),
            titleColor: Colors.white,
            titleWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}

// ignore: must_be_immutable
class _TitleMenuItem extends StatelessWidget{

  String title;
  IconData icon;
  Widget gotoWidget;
  Color? titleColor;
  FontWeight? titleWeight;
  // ignore: unused_element
  _TitleMenuItem({required this.title, required this.icon, required this.gotoWidget, this.titleColor, this.titleWeight});
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Icon(icon, size: 27, color: titleColor ?? Colors.black,),
          const SizedBox(width: 20,),
          Text(title, style: TextStyle(fontSize: 17, fontWeight: titleWeight ?? FontWeight.normal, color: titleColor ?? Colors.black),),
        ],
      ),
      
      onTap: (){
        Navigator.pop(context);
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => gotoWidget),
        );
      },
    );
  }
}