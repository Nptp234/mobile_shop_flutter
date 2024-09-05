import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/data/models/chatbot.dart';

class ChatbotProvider with ChangeNotifier{
  final List<Chatbot> _history = [];
  UnmodifiableListView<Chatbot> get history => UnmodifiableListView(_history);

  void addHistory(Chatbot chat){
    _history.add(chat);
    notifyListeners();
  }
}