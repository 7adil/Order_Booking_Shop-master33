class OrderModel{
  int? id;
  String? ShopName;
  String? OwnerName;
  String? PhoneNo;
  String? Brand;
  String? ItemsDescription;
  int? Qty;


  OrderModel({this.id,this.ShopName,this.OwnerName,this.PhoneNo,this.Brand,this.ItemsDescription, this.Qty});

  factory OrderModel.fromMap(Map<dynamic,dynamic> json){
    return OrderModel(

        id: json['id'],
        ShopName: json['Shop Name'],
        OwnerName:json['Owner Name'],
        PhoneNo: json['Phone No'],
        Brand: json['Brand'],
        ItemsDescription: json['Items Description'],
        Qty: json['Qty']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Shop Name': ShopName,
      'Owner Name': OwnerName,
      'Phone No': PhoneNo,
      'Brand': Brand,
      'Items Description': ItemsDescription,
      'Qty': Qty

    };
  }
}