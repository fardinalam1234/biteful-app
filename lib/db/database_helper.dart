import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/order.dart';
import '../models/order_item.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('biteful.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        restaurantName TEXT NOT NULL,
        total REAL NOT NULL,
        status TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE order_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        orderId INTEGER NOT NULL,
        itemName TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        unitPrice REAL NOT NULL,
        FOREIGN KEY(orderId) REFERENCES orders(id) ON DELETE CASCADE
      )
    ''');
  }

  Future<int> insertOrder(Map<String, dynamic> order, List<Map<String, dynamic>> items) async {
    final db = await instance.database;
    return await db.transaction<int>((txn) async {
      final id = await txn.insert('orders', order);
      for (var item in items) {
        await txn.insert('order_items', {...item, 'orderId': id});
      }
      return id;
    });
  }

  Future<List<Map<String, dynamic>>> getOrders() async {
    final db = await instance.database;
    return await db.query('orders', orderBy: 'createdAt DESC');
  }

  Future<List<Map<String, dynamic>>> getOrderItems(int orderId) async {
    final db = await instance.database;
    return await db.query('order_items', where: 'orderId = ?', whereArgs: [orderId]);
  }

  Future<List<Map<String, dynamic>>> getFrequentlyOrderedItems({int limit = 5}) async {
    final db = await instance.database;
    final result = await db.rawQuery('''
    SELECT itemName, SUM(quantity) as totalQuantity
    FROM order_items
    GROUP BY itemName
    ORDER BY totalQuantity DESC
    LIMIT ?
  ''', [limit]);
    return result;
  }

  Future<void> clearAllOrders() async {
    final db = await instance.database;
    await db.delete('order_items');
    await db.delete('orders');
  }

  // --- Helper Methods for easier use by UI ---

// Return a list of Order model objects (instead of raw maps)
  Future<List<Order>> fetchOrdersAsModels() async {
    final rows = await getOrders();
    return rows.map((r) => Order.fromMap(r)).toList();
  }

// Convenience wrapper: insert order + items using model objects
  Future<int> insertOrderObjects(Order order, List<OrderItem> items) async {
    return await insertOrder(order.toMap(), items.map((i) => i.toMap()).toList());
  }

// Shortcut for frequently ordered items
  Future<List<Map<String, dynamic>>> frequentlyOrdered({int limit = 5}) async {
    return getFrequentlyOrderedItems(limit: limit);
  }
}
