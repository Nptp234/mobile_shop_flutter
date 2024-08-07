// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/data/models/user.dart';
import 'package:mobile_shop_flutter/models/const.dart';
import 'package:mobile_shop_flutter/models/list_settings.dart';

class AccountCenter extends StatefulWidget{
  const AccountCenter({super.key});

  @override
  _AccountCenter createState() => _AccountCenter();
}

class _AccountCenter extends State<AccountCenter>{

  final user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _header(context),
      body: const SettingsList()
    );
  }

  PreferredSize _header(BuildContext context){
    return PreferredSize(
      preferredSize: Size.fromHeight(getMainHeight(context)/3), 
      child: Container(
        width: getMainHeight(context),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),

        decoration: const BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(color: Colors.black26, width: 1)
          ),
        ),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              //image
              Stack(
                children: [
                  
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: SizedBox(
                      width: 150,
                      height: 150,

                      child: Image.network(user.imgUrl!, fit: BoxFit.cover,),
                    ),
                  ),
                  Positioned(
                    bottom: -5,
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        
                      },

                      icon: Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(100)),
                        child: const Center(child: Icon(Icons.edit, size: 20, color: Colors.white,),),
                      ),
                    )
                  ),

                ],
              ),

              //username
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),

                child: Center(
                  child: Text(user.username!, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),),
                ),
              ),

              //phonenumber
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 10, right: 10),

                child: Center(
                  child: Text(phoneFormated(user.phoneNumber!), style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 17),),
                ),
              )

            ],
          ),
        ),
      )
    );
  }

}