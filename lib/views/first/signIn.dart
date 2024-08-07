import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/data/api/user_api.dart';
import 'package:mobile_shop_flutter/models/bottom_menu.dart';
import 'package:mobile_shop_flutter/models/const.dart';
import 'package:mobile_shop_flutter/views/first/signUp.dart';
import 'package:mobile_shop_flutter/views/second/3d_page.dart';
import 'package:mobile_shop_flutter/views/second/home.dart';

class SignIn extends StatefulWidget{


  _SignIn createState() => _SignIn();
}

class _SignIn extends State<SignIn>{

  TextEditingController userName = TextEditingController();
  TextEditingController passWord = TextEditingController();

  final userAPI = UserAPI();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _header(context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: _body(),
      )
    );
  }

  //header
  PreferredSize _header(BuildContext context){
    return PreferredSize(
      preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.25),
      child: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: mainColor.withOpacity(0.5),
              spreadRadius: 15,
              blurRadius: 15,
            ),
          ]
        ),

        child: const Center(
          child: Text('WELLCOME BACK', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
        ),
      )
    );
  }

  Widget _body(){
    return Container(
      width: double.infinity,

      padding: EdgeInsets.only(top: 70),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          _inputFieldColumn(),
          SizedBox(height: 20,),
          
          //button
          _signInBtn(context),
          _signUpBtn(context),
          _line(),
          _signInGGBtn(context)
        ],
      ),
    );
  }

  Widget _inputFieldColumn(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        InputFieldCustom(controller: userName, hintText: 'Your username', isObsucre: false),
        const SizedBox(height: 20,),
        InputFieldCustom(controller: passWord, hintText: 'Your password', isObsucre: true),
      ],
    );
  }

  bool _isLoading = false;

  Widget _signInBtn(BuildContext context){
    return GestureDetector(
      onTap: () async{
        // Navigator.push(context, MaterialPageRoute(builder: (context) => BottomMenu(child: HomePage())));
        setState(() {
          _isLoading=true;
        });
        final String sign = await userAPI.signIn(userName.text, passWord.text);
        if(sign=='200'){
          _isLoading=false;
          // ignore: use_build_context_synchronously
          Navigator.push(context, MaterialPageRoute(builder: (context) => BottomMenu(child: const HomePage())));
        }
      },

      child: Container(
        width: MediaQuery.of(context).size.width/1.75,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),

        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: mainColor, width: 2)
        ),

        child: !_isLoading?
          const Text('Sign In', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
          : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _signUpBtn(BuildContext context){
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
      },

      child: Container(
        width: MediaQuery.of(context).size.width/1.75,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),

        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey, width: 2)
        ),

        child: const Text('Sign Up', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
      ),
    );
  }

  Widget _signInGGBtn(BuildContext context){
    return GestureDetector(
      onTap: () {
        
      },

      child: Container(
        width: 300,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),

        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey, width: 2)
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Image.asset('assets/logo_icon/Google__G__logo.png', width: 30, height: 30,),
            // SizedBox(width: 30,),
            const Text('Sign in with Google', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }

  Widget _line(){
    return Stack(
      alignment: Alignment.center,

      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 20, right: 20),

          child: const Divider(
            color: Colors.grey, // Màu sắc của đường viền
            thickness: 1.0,
          ),
        ),

        Container(
          padding: const EdgeInsets.all(3),
            color: const Color.fromARGB(255, 255, 255, 255),
            child: const Text(
              'Or',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
              ),
            ),
          ),
        ],
      );
  }
}