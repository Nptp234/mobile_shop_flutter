import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/data/api/chatbot_api.dart';
import 'package:mobile_shop_flutter/models/const.dart';

class SupportPage extends StatefulWidget{
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPage();
}

class _SupportPage extends State<SupportPage>{

  TextEditingController messController = TextEditingController();
  ChatbotApi chatbotApi = ChatbotApi();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          _body(context),
          
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _footer(context),
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context){
    return Container(
      width: getMainWidth(context),
      height: getMainHeight(context),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
    );
  }

  Widget _footer(BuildContext context){
    return Container(
      width: getMainWidth(context),
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: TextFormField(
        controller: messController,
        decoration: InputDecoration(
          fillColor: Colors.white,
          border: const OutlineInputBorder(),
          enabledBorder: null,
          focusedBorder: null,
          errorBorder: null,
          disabledBorder: null,
          hintText: "Message...",
          suffixIcon: IconButton(onPressed: () {
            chatbotApi.sendMess(messController.text);
          }, 
          icon: const Icon(Icons.arrow_forward_ios)),
        ),
      ),
    );
  }
}