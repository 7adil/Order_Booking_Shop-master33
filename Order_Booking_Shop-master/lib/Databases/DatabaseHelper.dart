import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const String databaseName = 'your_database.db';
  static const int databaseVersion = 1;
  DatabaseHelper dbHelper = DatabaseHelper.instance;

  DatabaseHelper._publicConstructor();
  static final DatabaseHelper instance = DatabaseHelper._publicConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), databaseName);
    return await openDatabase(
      path,
      version: databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE shop_details(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        shopName TEXT,
        shopAddress TEXT,
        ownerName TEXT,
        ownerCnic TEXT,
        phoneNumber TEXT
      )
    ''');

  }

  Future<int> insertShopDetails(ShopDetails shopDetails) async {
    final db = await database;
    return await db.insert('shop_details', shopDetails.toMap());
  }
}



class ShopDetails {
  int? id;
  String shopName;
  String shopAddress;
  String ownerName;
  String ownerCnic;
  String phoneNo;

  ShopDetails({
    required this.id, // Initialize the 'id' field
    required this.shopName,
    required this.shopAddress,
    required this.ownerName,
    required this.ownerCnic,
    required this.phoneNo,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id, // Include 'id' in the map
      'shopName': shopName,
      'shopAddress': shopAddress,
      'ownerName': ownerName,
      'ownerCnic': ownerCnic,
      'phoneNumber': phoneNo,
    };
  }
}

