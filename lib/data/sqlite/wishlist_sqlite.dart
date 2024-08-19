import 'dart:developer';

import 'package:mobile_shop_flutter/data/sqlite/main_sqlite.dart';

class WishlistSqlite {
  final _sqlite = SQLiteService();

  Future<void> insert(String id) async{
    final db = await _sqlite.database;
    var data = db.rawQuery('insert into wishlist(productId) values ($id)');
    log('inserted $data');
  }

  Future<void> remove(String id) async{
    final db = await _sqlite.database;
    var data = db.rawQuery('delete from wishlist where productId = $id');
    log('updated $data');
  }

  Future<List<String>> getList() async{
    final db = await _sqlite.database;
    List<Map<String, dynamic>> data = await db.rawQuery('select * from wishlist');
    List<String> lst = data.map((row) => row['productId'].toString()).toList();
    return lst;
  }
}