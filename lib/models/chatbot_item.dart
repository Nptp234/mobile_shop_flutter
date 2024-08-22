import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_shop_flutter/data/models/chatbot.dart';
import 'package:mobile_shop_flutter/data/models/user.dart';
import 'package:mobile_shop_flutter/models/const.dart';


class ChatbotItem extends StatefulWidget{
  ChatbotItem({super.key, required this.chatbot});
  Chatbot chatbot;

  @override
  State<ChatbotItem> createState() => _ChatbotItem();
}

class _ChatbotItem extends State<ChatbotItem>{
  final user = User();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        //icon
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              // border: Border.all(width: 2, color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),

            child: widget.chatbot.username=='Gemini'?
              Image.asset('assets/logo_icon/cohere_icon.png', fit: BoxFit.cover,):
              Image.network(user.imgUrl!, fit: BoxFit.cover,)
          ),
        ),
        const SizedBox(width: 15,),

        //text
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            //name
            Text(widget.chatbot.username!, 
              style: GoogleFonts.roboto(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
            const SizedBox(height: 7,),
            //note
            SizedBox(
              width: getMainWidth(context)-(15+70),
              child: Text(widget.chatbot.note!, style: GoogleFonts.roboto(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.normal),),
            )
          ],
        )
      ],
    );
  }

}