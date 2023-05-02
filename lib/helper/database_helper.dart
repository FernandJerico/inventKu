import 'package:inventku/model/item_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static late Database _database;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  final String _tableName = 'item';

  Future<Database> _initializeDb() async {
    var db = openDatabase(join(await getDatabasesPath(), 'item_db.db'),
        onCreate: (db, version) async {
      await db.execute(
        '''CREATE TABLE $_tableName(
        id INTEGER PRIMARY KEY, 
        nama TEXT, 
        harga INT,
        stok INT,
        tanggal DATE,
        gambar BLOB,
        createdBy TEXT)''',
      );
    }, version: 1);
    return db;
  }

  Future<void> insertItem(ItemModel item) async {
    final Database db = await database;
    await db.insert(_tableName, item.toMap());
  }

  Future<List<ItemModel>> getItem() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);
    return results.map((e) => ItemModel.fromMap(e)).toList();
  }

  Future<ItemModel> getItemById(int id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return results.map((e) => ItemModel.fromMap(e)).first;
  }

  Future<void> updateItem(int id, ItemModel item) async {
    final db = await database;
    await db.update(
      _tableName,
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<void> deleteItem(int id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<ItemModel>> searchData(String keyword) async {
    final db = await database;
    var res = await db
        .query(_tableName, where: "nama LIKE ?", whereArgs: ['%$keyword%']);
    List<ItemModel> list =
        res.isNotEmpty ? res.map((c) => ItemModel.fromMap(c)).toList() : [];
    return list;
  }
}
