class User{
  String? id, username, email, password, imgUrl;

  User({this.id, this.username, this.email, this.password, this.imgUrl});

  User.fromJson(Map<dynamic, dynamic> e){
    id = e['ID'];
    username = e['Username'];
    email = e['Email'];
    password = e['Password'];
    imgUrl = e['ProfileImg'];
  }

  Map<dynamic, dynamic> toJson(){
    final Map<dynamic, dynamic> data = Map<dynamic, dynamic>();
    data['ID'] = id;
    data['Username'] = username;
    data['Email'] = email;
    data['Password'] = password;
    data['ProfileImg'] = imgUrl;
    return data;
  }
}