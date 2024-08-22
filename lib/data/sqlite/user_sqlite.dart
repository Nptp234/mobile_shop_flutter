import 'dart:developer';

import 'package:mobile_shop_flutter/data/sqlite/main_sqlite.dart';

class UserSqlite{
  final _sqlite = SQLiteService();

  addUser(String username, String password) async{
    final db = await _sqlite.database;
    var data = db.rawQuery('insert into user(username, password) values (?, ?)', [username, password]);
    log('inserted $data');
  }

  deleteUser() async{
    final db = await _sqlite.database;
    var data = db.rawQuery('delete from user');
    log('deleted $data');
  }

  updateUser(String username, String password) async{
    await deleteUser();
    await addUser(username, password);
  }

  Future<Map<String, dynamic>> getUser() async{
    final db = await _sqlite.database;
    List<Map<String, dynamic>> data = await db.rawQuery('select * from user');
    log('$data');
    return data[0];
  }
}