import 'dart:async';
import 'dart:io';
import 'package:password/DB/KeyList.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'UserList.dart';

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

    await db.execute('''
      CREATE TABLE users (
      id INTEGER PRIMARY KEY,
      name TEXT,
      user TEXT,
      password TEXT)
    ''');
  }

  Future<void> insert(String key) async {
    try {
      var dbClient = await database;
      await dbClient?.transaction((txn) async {
        await txn.rawInsert('''
          INSERT INTO keys(key) VALUES('$key')
        ''');
      });
    } catch (e) {
      print('Error inserting key: $e');
    }
  }

  Future<void> insertUser(String name, String user, String password) async {
    try {
      var dbClient = await database;
      await dbClient?.transaction((txn) async {
        await txn.rawInsert('''
          INSERT INTO users(name, user, password) VALUES('$name', '$user', '$password');
        ''');
      });
    } catch (e) {
      print('Error inserting user: $e');
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

  Future<void> deleteUser(int id) async {
    try {
      var dbClient = await database;
      await dbClient?.transaction((txn) async {
        await txn.rawInsert('''
          DELETE FROM users WHERE id = $id
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
        await txn.rawInsert('DELETE FROM users');
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
      List<KeyList> keys = [];
      if (maps!.isNotEmpty) {
        for (int i = 0; i < maps.length; i++) {
          keys.add(KeyList.fromMap(maps[i]));
        }
      }
      return keys;
    } catch (e) {
      print('Error getting keys: $e');
      return [];
    }
  }

  Future<List<UserList>> getAllUser() async {
    try {
      var dbClient = await database;
      List<Map>? maps = (await dbClient?.query('users'))?.cast<Map>();
      List<UserList> users = [];
      if (maps!.isNotEmpty) {
        for (int i = 0; i < maps.length; i++) {
          users.add(UserList.fromMap(maps[i]));
        }
      }
      return users;
    } catch (e) {
      print('Error getting users: $e');
      return [];
    }
  }

  Future<List<KeyList>> getKey(String search) async {
    try {
      var dbClient = await database;
      List<Map>? maps = (await dbClient?.query('keys'))?.cast<Map>();
      List<KeyList> keys = [];
      if (maps!.isNotEmpty) {
        for (int i = 0; i < maps.length; i++) {
          if(maps[i]['key'] == search) {
            keys.add(KeyList.fromMap(maps[i]));
          } else if(maps[i]['id'] == search) {
            keys.add(KeyList.fromMap(maps[i]));
          }
        }
      }
      return keys;
    } catch (e) {
      print('Error getting keys: $e');
      return [];
    }
  }

  Future<List<UserList>> getUser(String search) async {
    try {
      var dbClient = await database;
      List<Map>? maps = (await dbClient?.query('users'))?.cast<Map>();
      List<UserList> users = [];
      if (maps!.isNotEmpty) {
        for (int i = 0; i < maps.length; i++) {
          if(maps[i]['user'] == search) {
            users.add(UserList.fromMap(maps[i]));
          }
        }
      }
      return users;
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