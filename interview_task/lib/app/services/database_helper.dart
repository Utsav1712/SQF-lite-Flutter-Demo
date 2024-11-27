import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:interview_task/app/model/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {
  static Database? userDatabase;

  Future<Database> get database async {
    if (userDatabase != null) return userDatabase!;

    userDatabase = await createDatabase();
    return userDatabase!;
  }

  Future<Database> createDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/user_data.db';
    log(" >>>>>>>>>>> User Database path : $path");
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''CREATE TABLE user(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT,
            phoneNumber TEXT,
            dob TEXT,
            address TEXT
          )''');
    });
  }

  Future<void> insertUser(UserModel user) async {
    final db = await database;
    await db.insert('user', user.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    log("user inserted successfully");
  }

  Future<UserModel?> getUser(String id) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query('user', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return UserModel.fromJson(maps.first);
    }
    return null;
  }

  Future<List<UserModel>> getAllUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('user');
    return List.generate(maps.length, (i) {
      return UserModel.fromJson(maps[i]);
    });
  }


  Future<void> updateUser(UserModel user) async {
    final db = await database;
    await db.update('user', user.toJson(), where: 'id = ?', whereArgs: [user.id]);
  }

  Future<int> deleteUser(String id) async {
    final db = await database;
    return await db.delete('user', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearUserTable() async {
    final db = await database;
    await db.delete('user');
  }
}
