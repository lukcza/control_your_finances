import 'dart:async';

import 'package:control_your_finances/service/bank_account_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'item_model.dart';

class DatabaseService {
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

  Future<void> _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const doubleType = 'REAL NOT NULL';

    await db.execute('''
    CREATE TABLE IF NOT EXISTS BankAccounts (
      id $idType,
      name $textType,
      accountNumber $textType
    )
  ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS Items (
      id $idType,
      title $textType,
      startDate $textType,
      nextDate $textType,
      amount $doubleType,
      frequency $textType
    )
  ''');
  }

  Future<ItemModel> createItem(ItemModel itemModel) async {
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

  Future<List<ItemModel>> readAllItems() async {
    final db = await instance.database;

    const orderBy = 'startDate ASC';
    final result = await db.query('Items', orderBy: orderBy);

    return result.map((json) => ItemModel.fromMap(json)).toList();
  }

  Future<int> updateItem(ItemModel item) async {
    final db = await instance.database;

    return db.update(
      'Items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> deleteItem(int id) async {
    final db = await instance.database;

    return await db.delete(
      'Items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //Bank Account service
  Future<BankAccountModel> createBankAccount(
      BankAccountModel bankAccountModel) async {
    final db = await instance.database;
    final id = await db.insert('BankAccounts', bankAccountModel.toMap());
    return bankAccountModel.copy(id: id);
  }

  Future<BankAccountModel?> readBankAccount(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      'BankAccounts',
      columns: ['id', 'name', 'accountBank'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return BankAccountModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<BankAccountModel>> readAllBankAccounts() async {
    final db = await instance.database;

    const orderBy = 'name ASC';
    final result = await db.query('BankAccounts', orderBy: orderBy);

    return result.map((json) => BankAccountModel.fromMap(json)).toList();
  }

  Future<int> deleteBankAccount(int id) async {
    final db = await instance.database;

    return await db.delete(
      'BankAccounts',
      where: ' id=?',
      whereArgs: [id],
    );
  }

  Future<int> updateBankAccount(BankAccountModel bankAccountModel) async {
    final db = await instance.database;

    return db.update(
      'Items',
      bankAccountModel.toMap(),
      where: 'id = ?',
      whereArgs: [bankAccountModel.id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
