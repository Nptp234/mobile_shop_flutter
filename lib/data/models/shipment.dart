class Shipment {
  String? userID, address, nameAddress;

  Shipment({this.userID, this.address, this.nameAddress});

  Shipment.fromJson(Map<dynamic, dynamic> e){
    userID = '${e['CustomerID']}';
    nameAddress = e['AddressName'];
    address = e['CustomerAddress'];
  }

  Map<dynamic, dynamic> toJson(){
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['CustomerID'] = userID;
    data['AddressName'] = nameAddress;
    data['CustomerAddress'] = address;
    return data;
  }
}