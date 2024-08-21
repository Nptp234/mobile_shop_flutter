import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/data/api/chatbot_api.dart';
import 'package:mobile_shop_flutter/data/models/chatbot.dart';
import 'package:mobile_shop_flutter/data/models/user.dart';
import 'package:mobile_shop_flutter/models/chatbot_item.dart';
import 'package:mobile_shop_flutter/models/const.dart';
import 'package:mobile_shop_flutter/state_controller/chatbot_provider.dart';
import 'package:provider/provider.dart';

class SupportPage extends StatefulWidget{
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPage();
}

class _SupportPage extends State<SupportPage>{

  TextEditingController messController = TextEditingController();
  ChatbotApi chatbotApi = ChatbotApi();
  final user = User();
  bool _isLoad = false;
  final ScrollController _scrollController = ScrollController();

  void _scrollToEnd() {
    if (_scrollController.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _header(context),
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

  PreferredSize _header(BuildContext context){
    return PreferredSize(
      preferredSize: Size.fromHeight(50), 
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(0, 1), blurRadius: 10)
          ]
        ),
        child: AppBar(
          backgroundColor: Colors.white,
          title: Text('Cohere Chatbot', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
        ),
      )
    );
  }

  Widget _body(BuildContext context){
    return Container(
      width: getMainWidth(context),
      height: double.infinity,
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 75),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Consumer<ChatbotProvider>(
        builder: (context, value, child) {

          _scrollToEnd();

          return ListView.builder(
            itemCount: value.history.isEmpty?1:value.history.length,
            scrollDirection: Axis.vertical,
            physics: const ScrollPhysics(),

            itemBuilder: (context, index){
              return value.history.isEmpty?
                Center(
                  child: SizedBox(
                    width: 200, 
                    
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(bottom: 10, top: 20),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Image.asset('assets/logo_icon/cohere_icon.png', fit: BoxFit.cover,),
                        ),
                        const Text('Wellcome to Cohere! How can we help you?', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                      ],
                    )
                  ),
                ):
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: ChatbotItem(chatbot: value.history[index],),
                );
              
            }
          );
        },
      )
    );
  }

  Widget _footer(BuildContext context){
    return Consumer<ChatbotProvider>(
      builder: (context, value, child) {
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
              suffixIcon: Container(
                height: 60,
                padding: const EdgeInsets.all(10),
                child: !_isLoad?
                  IconButton(
                    onPressed: () async{
                      await _clickSend(value);
                    }, 
                    icon: const Icon(Icons.arrow_forward_ios)
                  ):
                  const CircularProgressIndicator(),
              )
            ),
          ),
        );
      },
    );
  }

  Future<void> _clickSend(ChatbotProvider value) async{
    if (messController.text.trim().isEmpty) {
      // Optionally show a snackbar or toast to alert the user
      return;
    }

    // Show a loading indicator, disable the button, etc.
    value.addHistory(
      Chatbot(
        username: user.username,
        note: messController.text,
      ),
    );
    setState(() {
      _isLoad=true;
    });

    try {
      String reply = await chatbotApi.sendMess(messController.text);

      value.addHistory(
        Chatbot(
          username: 'Cohere',
          note: reply,
        ),
      );
    } 
    catch (e) {
      // Handle the error, e.g., show an error message
      rethrow;
    } 
    finally {
      // Hide the loading indicator, re-enable the button, etc.
      messController.clear();
      setState(() {
        _isLoad=false;
      });
    }
  }
}