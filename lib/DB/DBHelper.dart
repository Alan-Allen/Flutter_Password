import 'dart:async';
import 'dart:io';
import 'package:password/DB/KeyList.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get database async {
    _db = await initdb();
    return _db;
  }

  Future<Database> initdb() async {
    Directory doc = await getApplicationDocumentsDirectory();
    String path = join(doc.path, 'App.db');
    var database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE keys (
      id INTEGER PRIMARY KEY,
      key TEXT)
    ''');
  }

  Future<void> insert(KeyList keyList) async {
    try {
      var dbClient = await database;
      await dbClient?.transaction((txn) async {
        await txn.rawInsert('''
          INSERT INTO keys(key) VALUES('${keyList.key}')
        ''');
      });
    } catch (e) {
      print('Error inserting key: $e');
    }
  }

  Future<void> delete(int id) async {
    try {
      var dbClient = await database;
      await dbClient?.transaction((txn) async {
        await txn.rawInsert('''
          DELETE FROM keys WHERE id = $id
        ''');
      });
    } catch (e) {
      print('Error delete key: $e');
    }
  }

  Future<void> deleteAll() async {
    try {
      var dbClient = await database;
      await dbClient?.transaction((txn) async {
        await txn.rawInsert('DELETE FROM keys');
      });
      print('All data clear successfully.');
    } catch (e) {
      print('Error clear: $e');
    }
  }

  Future<List<KeyList>> getAll() async {
    try {
      var dbClient = await database;
      List<Map>? maps = (await dbClient?.query('keys'))?.cast<Map>();
      List<KeyList> users = [];
      if (maps!.isNotEmpty) {
        for (int i = 0; i < maps.length; i++) {
          users.add(KeyList.fromMap(maps[i]));
        }
      }
      return users;
    } catch (e) {
      print('Error getting users: $e');
      return [];
    }
  }

  Future<List<KeyList>> getKey(String key) async {
    try {
      var dbClient = await database;
      List<Map>? maps = (await dbClient?.query('users'))?.cast<Map>();
      List<KeyList> keys = [];
      if (maps!.isNotEmpty) {
        for (int i = 0; i < maps.length; i++) {
          if(maps[i]['key'] == key) {
            keys.add(KeyList.fromMap(maps[i]));
          }
        }
      }
      return keys;
    } catch (e) {
      print('Error getting users: $e');
      return [];
    }
  }

  Future<void> update(KeyList keyList) async {
    try {
      var dbClient = await database;
      await dbClient?.transaction((txn) async {
        await txn.rawInsert('''
          UPDATE keys
          SET key = ${keyList.key} WHERE id = ${keyList.id};
        ''');
      });
    } catch (e) {
      print('Error update key: $e');
    }
  }
}