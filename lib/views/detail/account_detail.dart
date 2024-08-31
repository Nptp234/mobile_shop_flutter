import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/data/models/user.dart';
import 'package:mobile_shop_flutter/models/const.dart';

class AccountDetail extends StatefulWidget{
  const AccountDetail({super.key});

  @override
  State<AccountDetail> createState() => _AccountDetail();
}

class _AccountDetail extends State<AccountDetail>{

  final user = User();
  
  TextEditingController userName = TextEditingController();
  TextEditingController passWord = TextEditingController();
  TextEditingController emailControl = TextEditingController();

  @override
  void initState() {
    userName.text = user.username!;
    passWord.text = user.password!;
    emailControl.text = user.email!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerSub(context, 'Account Detail'),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const ScrollPhysics(),
          child: _body(context),
        ),
      )
    );
  }

  Widget _body(BuildContext context){
    return Container(
      width: getMainWidth(context),
      height: getMainHeight(context),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 30),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //img
          _img(context),
          _button(context, (){}),
          const SizedBox(height: 30,),
          //info
          _info(context),
        ],
      ),
    );
  }

  Widget _img(BuildContext context){
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: getMainHeight(context)/3,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Image.network(user.imgUrl!, fit: BoxFit.cover,),
      ),
    );
  }

  Widget _info(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Your information', style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
        const SizedBox(height: 20,),
        InputFieldCustom(controller: userName, hintText: 'Your username', isObsucre: false),
        InputFieldCustom(controller: passWord, hintText: 'Your password', isObsucre: false),
        InputFieldCustom(controller: emailControl, hintText: 'Your email', isObsucre: false),
        const SizedBox(height: 20,),
        _button(context, (){}),
      ],
    );
  }

  Widget _button(BuildContext context, GestureTapCallback action){
    return GestureDetector(
      onTap: action,
      child: Container(
            width: getMainWidth(context),
            height: 50,
            margin: const EdgeInsets.only(left: 100, right: 100, top: 30),
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.circular(10)
            ),
            child: const Center(child: Text('Update', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),),
          ),
    );
  }

}