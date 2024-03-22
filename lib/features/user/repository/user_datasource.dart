import 'package:flutter_exam_jubo/features/user/data/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'user_table_keys.dart';

class UserDatasource {
  static final UserDatasource _instance = UserDatasource._();

  factory UserDatasource() => _instance;
  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  UserDatasource._() {
    _initDatabase();
  }

  Future<Database> _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'users.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //create table
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      create table ${UserKeys.table} (
      ${UserKeys.columnId} integer primary key autoincrement,
      ${UserKeys.columnName} text not null,
      ${UserKeys.columnBirthday} integer not null,
      ${UserKeys.columnBreakfast} integer not null,
      ${UserKeys.columnLunch} integer not null,
      ${UserKeys.columnDinner} integer not null)
      ''');
  }

  Future<List<User>> getAllUsers() async {
    final db = await database;
    final maps = await db.query(UserKeys.table, orderBy: '_id DESC');
    return List.generate(maps.length, (index) => User.fromJson(maps[index]));
  }

  Future<int> addUser(User user) async {
    final db = await database;
    return db.transaction((txn) async => await txn.insert(
        UserKeys.table, user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace));
  }

  Future<int> updateUser(User user) async {
    final db = await database;
    return db.transaction((txn) async => await txn.update(
        UserKeys.table, user.toJson(),
        where: '_id = ?', whereArgs: [user.id]));
  }

  Future<int> deleteUser(User user) async {
    final db = await database;
    return db.transaction((txn) async => await txn
        .delete(UserKeys.table, where: '_id = ?', whereArgs: [user.id]));
  }

  Future<int> countBreakfast() async {
    final db = await database;
    final map = await db.query(UserKeys.table,
        columns: ['COUNT(*) as counts'],
        where: 'breakfast = ?',
        whereArgs: ['1']);
    final counts = map.isNotEmpty ? map.first['counts'] as int : 9999;
    return counts;
  }

  Future<int> countLunch() async {
    final db = await database;
    final map = await db.query(UserKeys.table,
        columns: ['COUNT(*) as counts'], where: 'lunch = ?', whereArgs: ['1']);
    final counts = map.isNotEmpty ? map.first['counts'] as int : 9999;
    return counts;
  }

  Future<int> countDinner() async {
    final db = await database;
    final map = await db.query(UserKeys.table,
        columns: ['COUNT(*) as counts'], where: 'dinner = ?', whereArgs: ['1']);
    final counts = map.isNotEmpty ? map.first['counts'] as int : 9999;
    return counts;
  }
}
