import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/data/api/user_api.dart';
import 'package:mobile_shop_flutter/data/sqlite/user_sqlite.dart';
import 'package:mobile_shop_flutter/models/const.dart';
import 'package:mobile_shop_flutter/views/first/signIn.dart';
import 'package:mobile_shop_flutter/views/second/home.dart';

class WaitingPage extends StatefulWidget{
  const WaitingPage({super.key});

  @override
  State<WaitingPage> createState() => _WaitingPage();
}

class _WaitingPage extends State<WaitingPage>{

  UserSqlite userSqlite = UserSqlite();
  final userApi = UserAPI();

  Future<bool> _checkData(BuildContext context) async{
    try{
      Map<String, dynamic> lst = await userSqlite.getUser();
      if(lst.isEmpty){
        //no local user
        return false;
      }
      else{
        final String sign = await userApi.signIn(lst['username'], lst['password']);
        if(sign=='200'){return true;}
        // ignore: use_build_context_synchronously
        else{return false;}
      }
    }
    catch(e){
      rethrow;
    }
  }

  goPage(BuildContext context, Widget widget){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getMainWidth(context),
      height: getMainHeight(context),
      padding: const EdgeInsets.all(10),
      color: mainColor,
      child: FutureBuilder<bool>(
        future: _checkData(context),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                //icon title
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.white, offset: Offset(-10, 10), blurRadius: 20)
                    ]
                  ),

                  child: Image.asset('assets/logo_icon/logo.png', fit: BoxFit.cover,),
                ),
                const SizedBox(height: 50,),

                //loading
                const Center(child: CircularProgressIndicator(backgroundColor: Colors.transparent, color: Colors.white,),),
              ],
            );
          }
          else if(snapshot.data==null){
            goPage(context, const SignIn());
            return const Center(child: SizedBox(),);
          }
          else if(snapshot.data!){
            goPage(context, const HomePage());
            return const Center(child: SizedBox(),);
          }
          else{
            goPage(context, const SignIn());
            return const Center(child: SizedBox(),);
          }
        },
      )
    );
  }

}