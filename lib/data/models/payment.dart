class Payment {
  String? id, method, img;
  Payment({this.id, this.method, this.img});

  Payment.fromJson(Map<dynamic, dynamic> e){
    id = '${e['ID']}';
    method = e['Method'];
    img = e['Image'][0]['url'];
  }

  Map<dynamic, dynamic> toJson(){
    Map<dynamic, dynamic> data = {};
    data['ID'] = id;
    data['Method'] = method;
    data['Image'] = img;
    return data;
  }
}