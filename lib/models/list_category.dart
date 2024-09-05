import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/data/api/category_api.dart';
import 'package:mobile_shop_flutter/data/models/category.dart';
import 'package:mobile_shop_flutter/models/const.dart';
import 'package:quickalert/quickalert.dart';

class CategoryList extends StatefulWidget{
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryList();
}

class _CategoryList extends State<CategoryList>{

  final categoryList = CategoryListModel();
  CategoryAPI categoryAPI = CategoryAPI();

  List<Category> lst = [];
  @override
  void initState() {
    super.initState();
    lst = categoryList.getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getMainWidth(context),
      height: 190,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      margin: const EdgeInsets.only(top: 30),

      child: FutureBuilder<List<Category>>(
        future: categoryAPI.setCategoryList(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          else if(!snapshot.hasData){
            WidgetsBinding.instance.addPostFrameCallback((_) {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Data is null!',
              );
            });

            return const SizedBox.shrink();
          }
          else{
            return Center(
              child: GridView.builder(
                itemCount: lst.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 0.5,
                  crossAxisSpacing: 1.5,
                  childAspectRatio: 2.0,
                ), 
                itemBuilder: (context, index){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Container(
                        width: 60, 
                        height: 60, 
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 10),
                        
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: secondaryColor.withOpacity(0.5),
                        ),

                        child: Image.network(lst[index].iconUrl!, fit: BoxFit.contain,),
                      ),
                      Text(lst[index].name!, style: const TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.normal),)
                    ],
                  );
                }
              ),
            );
          }
        },
      )
    );
  }

}