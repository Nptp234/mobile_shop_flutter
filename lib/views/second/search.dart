import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/data/models/product.dart';
import 'package:mobile_shop_flutter/models/product_item.dart';
import 'package:search_page/search_page.dart';

class Person implements Comparable<Person> {
  final String name, surname;
  final num age;

  const Person(this.name, this.surname, this.age);

  @override
  int compareTo(Person other) => name.compareTo(other.name);
}


class Search{

  List<Product> product = ProductListModel().getList();

  search(BuildContext context) => showSearch(
    context: context, 
    delegate: SearchPage(
      onQueryUpdate: print,
      items: product,
      searchLabel: 'Search...',
      suggestion: const Center(
        child: Text('Please filter search by name, category or branch', style: TextStyle(fontSize: 20, color: Colors.black), textAlign: TextAlign.center,),
      ),
      failure: const Center(
        child: Text('No product found :(', style: TextStyle(fontSize: 20, color: Colors.black), textAlign: TextAlign.center,),
      ),
      filter: (product) => [
        product.name,
        product.categoryName,
      ],
      sort: (a, b) => a.compareTo(b),
      builder: (product) {
        return Container(
          margin: const EdgeInsets.only(left: 25, right: 25, top: 25),
          child: ProductItem(product: product),
        );
      }
    ),
  );

}