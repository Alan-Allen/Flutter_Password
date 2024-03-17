import 'package:flutter/material.dart';
import 'package:password/DB/DBHelper.dart';
import 'package:password/routes/router.dart';

import 'DB/UserList.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DBHelper dbHelper = DBHelper();
  await dbHelper.initdb();
  await dbHelper.deleteAll();
  await dbHelper.insert("1234");
  await dbHelper.insertUser('Admin', 'admin', '1234');
  await dbHelper.insertUser('Alan', 'alan', 'Alan123');
  List<UserList> users = await dbHelper.getAllUser();
  print("get user data:");
  for (var user in users) {
    print("ID: ${user.id}, Name: ${user.name}, User: ${user.user}, Password: ${user.password}");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}

