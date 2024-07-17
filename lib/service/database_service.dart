import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'item_model.dart';

class DatabaseService{
  static final DatabaseService instance = DatabaseService._init();

  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('Items.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const doubleType = 'REAL NOT NULL';

    await db.execute('''
    CREATE TABLE IF NOT EXISTS Items(
    id $idType,
     title $textType,
  startDate $textType,
  nextDate $textType,
  amount $doubleType,
  frequency $textType
  )
''');
  }

  Future<ItemModel> create(ItemModel itemModel) async {
    final db = await instance.database;

    final id = await db.insert('Items', itemModel.toMap());
    return itemModel.copy(id: id);
  }

  Future<ItemModel?> readItems(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      'Items',
      columns: ['id', 'title', 'startDate', 'nextDate', 'amount', 'frequency'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ItemModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<ItemModel>> readAllEvents() async {
    final db = await instance.database;

    const orderBy = 'startDate ASC';
    final result = await db.query('Items', orderBy: orderBy);

    return result.map((json) => ItemModel.fromMap(json)).toList();
  }

  Future<int> update(ItemModel event) async {
    final db = await instance.database;

    return db.update(
      'Items',
      event.toMap(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      'Items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
