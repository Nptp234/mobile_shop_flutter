import 'dart:convert';

import 'package:mobile_shop_flutter/data/api/storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_shop_flutter/data/models/category.dart';

class CategoryAPI{

  final categoryList = CategoryListModel();

  Future<Map<dynamic, dynamic>> _getCategoryFromAPI() async{
    try{
      String? key = await read();
      String? url = await readUrl('categoryUrl');

      final res = await http.get(Uri.parse(url!), headers: {'Authorization':'Bearer $key'});
      if(res.statusCode==200){return jsonDecode(res.body);}
      else{throw Exception('Fail to load data!');}
    }
    catch(e){
      rethrow;
    }
  }

  Future<bool> setCategoryList() async{
    if(categoryList.getCategoryList().isEmpty){
      var data = await _getCategoryFromAPI();
      var records = data['records'];

      List<Category> lst = [];

      for(var record in records){
        var field = record['fields'];
        lst.add(
          Category.fromJson(field)
        );
      }

      categoryList.setCategoryList(lst);
    }

    if(categoryList.getCategoryList().isNotEmpty){return true;}
    else {return false;}
  }
}