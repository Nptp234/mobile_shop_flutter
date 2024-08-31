class User{
  //Singleton connection
  User._privateConstructor();

  // Static instance
  static final User _instance = User._privateConstructor();

  // Factory constructor to return the static instance
  factory User() {
    return _instance;
  }

  String? id, username, email, password, imgUrl, phoneNumber, imgName;

  clear(){
    id=null;username=null;email=null;password=null;imgUrl=null;imgName=null;
  }

  fromJson(Map<dynamic, dynamic> e){
    id = e['ID'];
    username = e['Username'];
    email = e['Email'];
    password = e['Password'];
    imgUrl = e['ProfileImg'][0]['url'];
    imgName = e['ProfileImg'][0]['filename'];
    phoneNumber = e['Phone Number'];
  }

  Map<dynamic, dynamic> toJson(){
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['ID'] = id;
    data['Username'] = username;
    data['Email'] = email;
    data['Password'] = password;
    data['ProfileImg'] = imgUrl;
    data['Phone Number'] = phoneNumber;
    return data;
  }
}