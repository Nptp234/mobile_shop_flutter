class Bill{
  String? id, customerName, shipmentAddress, paymentMethod, totalPrice, dateCreated, status;
  Map<dynamic, dynamic>? carts;
  Bill({this.id, this.customerName, this.shipmentAddress, this.paymentMethod, this.totalPrice, this.dateCreated, this.carts, this.status});

  void setCarts(Map<dynamic, dynamic> lst){
    carts = lst;
  }

  Bill.fromJson(Map<dynamic, dynamic> e){
    id = '${e['ID']}';
    customerName = e['Username'];
    shipmentAddress = e['CustomerAddress'];
    paymentMethod = e['Method'];
    totalPrice = '${e['TotalPrice']}';
    dateCreated = e['DateCreate'];
    status = e['Status'];
  }
}