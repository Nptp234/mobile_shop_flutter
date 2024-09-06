import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/data/api/user_api.dart';
import 'package:mobile_shop_flutter/data/models/user.dart';
import 'package:mobile_shop_flutter/models/const.dart';
import 'package:quickalert/quickalert.dart';

class AccountDetail extends StatefulWidget{
  const AccountDetail({super.key});

  @override
  State<AccountDetail> createState() => _AccountDetail();
}

class _AccountDetail extends State<AccountDetail>{

  final user = User();
  final userApi = UserAPI();

  String imgUrl = '';
  
  TextEditingController userName = TextEditingController();
  TextEditingController passWord = TextEditingController();
  TextEditingController emailControl = TextEditingController();

  @override
  void initState() {
    userName.text = user.username!;
    passWord.text = user.password!;
    emailControl.text = user.email!;
    imgUrl=user.imgUrl!;
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

  bool imgLoad = false;

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
          _button(context, imgLoad, () async{
            File? img = await pickImg();
            if(img==null){
              QuickAlert.show(context: context, type: QuickAlertType.error, text: 'You have canceled the upload!');
            }else{
              setState(() {
                imgLoad = true;
              });
              bool isUp = await userApi.updateImg(img);
              if(isUp){
                String url = await userApi.getImageUrl();
                setState(() {
                  imgUrl = url;
                  imgLoad=false;
                }
              );}
              else{
                setState(() {
                  imgLoad = false;
                });
                QuickAlert.show(context: context, type: QuickAlertType.error, text: 'Please try again later!');
              }
            }
          }),
          const SizedBox(height: 30,),

          //info
          _info(context),
        ],
      ),
    );
  }

  Widget _img(BuildContext context){
    return Container(
      width: getMainWidth(context),
      margin: const EdgeInsets.only(bottom: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: getMainHeight(context)/3,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Image.network(imgUrl, fit: BoxFit.cover,),
        ),
      ),
    );
  }

  bool infoLoad = false;

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
        _button(context, infoLoad, (){}),
      ],
    );
  }

  Widget _button(BuildContext context, bool isLoading, GestureTapCallback action){
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
            child: Center(
              child: !isLoading?
                const Text('Update', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),):
                const CircularProgressIndicator(color: Colors.white,),
            ),
          ),
    );
  }

  Future<File?> pickImg() async{
    try{
      FilePickerResult? result = await FilePicker.platform.pickFiles(allowedExtensions: ['png', 'jpg', 'jpeg'], type: FileType.custom);
      if(result!=null){
        return File(result.files.single.path!);
      }else{return null;}
    }
    catch(e){
      rethrow;
    }
  }

}