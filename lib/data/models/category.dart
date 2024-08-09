class Category{
  String? id, name, iconUrl;

  Category({this.id, this.name, this.iconUrl});

  Category.fromJson(Map<dynamic, dynamic> e){
    id = '${e['ID']}';
    name = e['Name'];
    iconUrl = e['Icon'][0]['url'];
  }

  Map<dynamic, dynamic> toJson(){
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['ID'] = id;
    data['Name'] = name;
    data['Icon'][0]['url'] = iconUrl;
    return data;
  }
}

class CategoryListModel{
  //Singleton connection
  CategoryListModel._privateConstructor();

  // Static instance
  static final CategoryListModel _instance = CategoryListModel._privateConstructor();

  // Factory constructor to return the static instance
  factory CategoryListModel() {
    return _instance;
  }

  List<Category> categoryLst = [];

  void setCategoryList(List<Category> lst){
    categoryLst = lst;
  }

  List<Category> getCategoryList(){
    return categoryLst;
  }
}