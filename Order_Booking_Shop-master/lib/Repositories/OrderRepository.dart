import 'package:order_booking_shop/Databases/DBHelper.dart';
import 'package:order_booking_shop/Databases/Util.dart';
import 'package:order_booking_shop/Models/OrderModel.dart';

class OrderRepository {

  DBHelper dbHelper = DBHelper();



  Future<List<OrderModel>> getOrder() async {
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient!.query(tableName, columns: ['id', 'Shop Name','Owner Name','Phone No','Brand','Items Description','Qty']);
    List<OrderModel> order = [];

    for (int i = 0; i < maps.length; i++) {
      order.add((OrderModel.fromMap(maps[i])));
    }
    return order;


  }
  Future<int> add(OrderModel orderModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient!.insert(tableName , orderModel.toMap());
  }

  Future<int> update(OrderModel orderModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient!.update(tableName , orderModel.toMap(),
        where: 'id=?', whereArgs: [orderModel.id] );
  }

  Future<int> delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient!.delete(tableName ,
        where: 'id=?', whereArgs: [id] );
  }
}



