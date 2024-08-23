import 'dart:collection';

import 'package:flutter/material.dart';

class Notification{
  String? note, title, status, date;
  Notification({this.note, this.title, this.status, this.date});
}

class NotificationProvider with ChangeNotifier{
  // ignore: prefer_final_fields
  List<Notification> _lstUnread = [];
  UnmodifiableListView<Notification> get lstUnread => UnmodifiableListView(_lstUnread);
  // ignore: prefer_final_fields
  List<Notification> _lstRead = [];
  UnmodifiableListView<Notification> get lstRead => UnmodifiableListView(_lstRead);

  addUnread(Notification n){
    _lstUnread.add(n);
    notifyListeners();
  }

  addRead(Notification n){
    if(_lstUnread.contains(n)){_lstUnread.remove(n);}
    _lstRead.add(n);
    notifyListeners();
  }
}