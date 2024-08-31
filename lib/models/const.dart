
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Color mainColor = const Color(0xFFFFA62F);
Color secondaryColor = const Color(0xFFFFC96F);
Color tempColor = const Color(0xFFFFE8C8);

TextStyle itemMenu = const TextStyle(
  fontWeight: FontWeight.bold,
);

double getMainHeight(BuildContext context){
  return MediaQuery.of(context).size.height;
}

double getMainWidth(BuildContext context){
  return MediaQuery.of(context).size.width;
}

String phoneFormated(String phone){
  if(phone.length==10){
    return '${phone.substring(0, 4)}-${phone.substring(4, 7)}-${phone.substring(7, 10)}';
  }else{return '';}
}

String priceFormated(String price){
  return NumberFormat('#,##0').format(double.parse(price));
}

class InputFieldCustom extends StatelessWidget{

  final TextEditingController controller;
  final String hintText;
  final bool isObsucre;
  const InputFieldCustom({super.key, required this.controller, required this.hintText, required this.isObsucre});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 10, right: 10),
      padding: const EdgeInsets.all(5),

      child: TextFormField(
        controller: controller,
        obscureText: isObsucre,

        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: secondaryColor, width: 1, style: BorderStyle.solid)
          ),
        ),
      ),
      
    );
  }

}

PreferredSize headerSub(BuildContext context, String title){
    return PreferredSize(
      preferredSize: const Size.fromHeight(100), 
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.grey, offset: Offset(0, 1), blurRadius: 5)
            ],
            color: Colors.white
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              IconButton(
                onPressed: () => Navigator.pop(context), 
                icon: const Icon(Icons.arrow_back,)
              ),
              const SizedBox(width: 20,),
              Text(title, style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),)
            ],
          ),
        )
      )
    );
  }

  String getFileNameFromUrl(String url) {
    return Uri.parse(url).pathSegments.last;
  }