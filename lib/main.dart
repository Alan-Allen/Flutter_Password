import 'package:flutter/material.dart';
import 'package:password/DB/DBHelper.dart';
import 'package:password/DB/KeyList.dart';
import 'package:password/routes/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DBHelper dbHelper = DBHelper();
  await dbHelper.initdb();
  await dbHelper.deleteAll();
  await dbHelper.insert("1234");
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

