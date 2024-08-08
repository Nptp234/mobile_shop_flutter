import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/data/models/user.dart';
import 'package:mobile_shop_flutter/models/const.dart';
import 'package:mobile_shop_flutter/models/slider.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage>{

  final user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _header(context),
      body: _body(),
    );
  }

  PreferredSize _header(BuildContext context){
    return PreferredSize(
      preferredSize: Size.fromHeight(getMainHeight(context)/3), 
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 30),
        width: getMainWidth(context),
        
        child: Column(
          children: [
            Row(
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

            //search bar
            Container(
              width: getMainWidth(context),
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              padding: const EdgeInsets.all(5),

              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: const TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.black54, size: 25,),
                  suffixIcon: IconButton(
                    onPressed: (){

                    },
                    icon: const Icon(Icons.sort, color: Colors.black, size: 25,),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.grey, width: 1)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.grey, width: 1))
                ),
              ),
            )
          ],
        )
      )
    );
  }

  Widget _body(){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: ScrollPhysics(),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          _slider(),
        ],
      ),
    );
  }

  Widget _slider(){
    return Container(
      width: getMainWidth(context),
      margin: const EdgeInsets.all(15),
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          //title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              const Text('Special Offer', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
              GestureDetector(
                onTap: () {
                  
                },
                child: const Text('See All', style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold, fontSize: 15),),
              )
            ],
          ),

          //slider
          const SliderBanner(),
        ],
      ),
    );
  }

}

