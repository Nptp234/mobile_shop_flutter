import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/models/const.dart';
import 'package:mobile_shop_flutter/views/first/signIn.dart';

class SignUp extends StatefulWidget {
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  TextEditingController userName = TextEditingController();
  TextEditingController passWord = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _header(context),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          child: _body(),
        ));
  }

  //header
  PreferredSize _header(BuildContext context) {
    return PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.25),
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
              ]),
          child: const Center(
            child: Text(
              'WELLCOME TO CITYPHONE',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }

  Widget _body() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 70),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _inputFieldColumn(),
          SizedBox(
            height: 20,
          ),

          //button
          _signUpBtn(context),
          _signInBtn(context),
          _line(),
          _signInGGBtn(context)
        ],
      ),
    );
  }

  Widget _inputFieldColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InputFieldCustom(
            controller: userName, hintText: 'Your username', isObsucre: false),
        SizedBox(
          height: 20,
        ),
        InputFieldCustom(
            controller: userName, hintText: 'Your phone', isObsucre: false),
        SizedBox(
          height: 20,
        ),
        InputFieldCustom(
            controller: passWord, hintText: 'Your password', isObsucre: true),
      ],
    );
  }

  Widget _signUpBtn(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: MediaQuery.of(context).size.width / 1.75,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: mainColor, width: 2)),
        child: Text(
          'Sign Up',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _signInBtn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignIn()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.75,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey, width: 2)),
        child: Text(
          'Sign In',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _signInGGBtn(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 300,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey, width: 2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo_icon/Google__G__logo.png',
              width: 30,
              height: 30,
            ),
            // SizedBox(width: 30,),
            Text(
              'Sign in with Google',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  Widget _line() {
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
