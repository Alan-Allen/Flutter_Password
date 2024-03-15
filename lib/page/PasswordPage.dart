import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password/DB/DBHelper.dart';

import '../DB/KeyList.dart';
import '../component/Button.dart';
import '../routes/router.dart';

class PasswordPage extends StatefulWidget {
  PasswordPage({super.key});

  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();

  late List<KeyList> keys = [];
  List<String> titleList = ["ID", "Password", "Set"];

  @override
  void initState() {
    super.initState();
    geAll();
    getKeysFromDB();
  }

  void getKeysFromDB() async {
    DBHelper dbHelper = DBHelper();
    await dbHelper.initdb();
    List<KeyList> keyList = await dbHelper.getAll();
    setState(() {
      keys = keyList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            print('Back to Home');
            router.go('/');
          },
        ),
        title: const Text('Password Management'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                print('Refresh Button Pressed');
                getKeysFromDB();
              },
              icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            hintText: 'Enter your Search',
                            labelText: 'Search',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(width: 3, color: Colors.greenAccent),
                              borderRadius: BorderRadius.circular(50.0),
                            )
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    _buildButton('Search', Colors.blue, () async {
                      print('Search Button Pressed');
                      String search = _searchController.text;
                      _searchController.clear();
                      List<KeyList> keyList = await getKey(search);
                      setState(() {
                        keys = keyList;
                      });
                    }),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: keys.length,
                  itemBuilder: (context, index) {
                    if(index == 0) {
                      return Column(
                        children: [
                          _buildHeader(titleList),
                          _buildKeyRow(keys[index], context)
                        ],
                      );
                    } else {
                        return _buildKeyRow(keys[index], context);
                    }
                  }
                ),
              ),
              Center(
                child: CustomButton(
                  onPressed: () {
                    print('Insert Button Pressed');
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Insert'),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: _keyController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Password',
                                    label: const Text('Password'),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(width: 3),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              CustomButton(
                                  onPressed: () {
                                    print('Close Button Pressed');
                                    Navigator.pop(context);
                                  },
                                  text: 'Close',
                                  color: Colors.red,
                                  textColor: Colors.white,
                                  width: 15, height: 10
                              ),
                              CustomButton(
                                  onPressed: () {
                                    print('Insert Button Pressed');
                                    String key = _keyController.text;
                                    insert(key);
                                    _keyController.clear();
                                    Navigator.pop(context);
                                    setState(() {
                                      getKeysFromDB();
                                    });
                                  },
                                  text: 'Insert',
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  width: 15, height: 10
                              ),
                            ],
                          );
                        }

                    );
                  },
                  text: 'Insert',
                  color: Colors.blue,
                  textColor: Colors.white,
                  width: 30, height: 15,
                ),
              ),
            ],
          )
        ),
      );
    }

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return CustomButton(
      onPressed: onPressed,
      text: text,
      color: color,
      textColor: Colors.white,
      width: 10,
      height: 10,
    );
  }

  Widget _buildKeyRow(KeyList key, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: Row(
        children: [
          Expanded(
              child: Text(
                "${key.id}",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),
          ),
          Expanded(
            child: Text(
              key.key,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: CustomButton(
                onPressed: () {
                  print('Setting Button Pressed');
                  _keyController.text = key.key;
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Setting'),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: _keyController,
                                decoration: InputDecoration(
                                  hintText: 'Enter your password',
                                  label: const Text('password'),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 3),
                                    borderRadius: BorderRadius.circular(20.0),
                                  )
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            CustomButton(
                              onPressed: () {
                                print('Delete Button Pressed');
                                delete(key.id);
                                Navigator.of(context).pop();
                                setState(() {
                                  getKeysFromDB();
                                });
                              },
                              text: 'Delete',
                              color: Colors.red,
                              textColor: Colors.white,
                              width: 15,
                              height: 10,
                            ),
                            CustomButton(
                              onPressed: () {
                                print('Close Button Pressed');
                                Navigator.of(context).pop();
                              },
                              text: 'Close',
                              color: Colors.orange,
                              textColor: Colors.white,
                              width: 15,
                              height: 10,
                            ),
                            CustomButton(
                              onPressed: () {
                                print('Update Button Pressed');
                                String _key = _keyController.text;
                                update(key.id, _key);
                                Navigator.of(context).pop();
                                setState(() {
                                  getKeysFromDB();
                                });
                              },
                              text: 'Update',
                              color: Colors.blue,
                              textColor: Colors.white,
                              width: 15,
                              height: 10,
                            ),
                          ],
                        );
                      },
                  );
                },
                text: 'Set',
                color: Colors.grey,
                textColor: Colors.white,
                width: 15, height: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(List title) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title[0],
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),
            ),
            Expanded(
              child: Text(
                title[1],
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),
            ),
            Expanded(
              child: Text(
                title[2],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      );
  }
}

void insert(String key) async {
  DBHelper dbHelper = DBHelper();
  await dbHelper.initdb();
  await dbHelper.insert(key);
  print("Insert data: $key");
}

Future<List<KeyList>> getKey(String search) async {
  DBHelper dbHelper = DBHelper();
  await dbHelper.initdb();
  List<KeyList> keys = await dbHelper.getKey(search);
  print("get key data:");
  for(var key in keys) {
    print("ID: ${key.id}, key: ${key.key}");
  }
  return keys;
}

void geAll() async {
  DBHelper dbHelper = DBHelper();
  await dbHelper.initdb();
  List<KeyList> keys = await dbHelper.getAll();
  print('Key data: ');
  for(var key in keys) {
    print('ID: ${key.id}, Key: ${key.key}');
  }
}

void update(int id, String key) async {
  DBHelper dbHelper = DBHelper();
  await dbHelper.initdb();
  KeyList keys = KeyList(id, key);
  await dbHelper.update(keys);
}

void delete(int id) async {
  DBHelper dbHelper = DBHelper();
  await dbHelper.initdb();
  await dbHelper.delete(id);
  print('delete $id');
}