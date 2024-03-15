import 'package:flutter/material.dart';

import '../DB/DBHelper.dart';
import '../DB/UserList.dart';
import '../component/Button.dart';
import '../routes/router.dart';

class AccountPage extends StatefulWidget {
  AccountPage({super.key});

  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();

  late List<UserList> users = [];
  List<String> titleList = ["ID", "Name", "User", "Password", "Set"];

  @override
  void initState() {
    super.initState();
    //getAll();
    getKeysFromDB();
  }

  void getKeysFromDB() async {
    DBHelper dbHelper = DBHelper();
    await dbHelper.initdb();
    List<UserList> userList = await dbHelper.getAllUser();
    setState(() {
      users = userList;
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
                      //List<KeyList> keyList = await getKey(search);
                      setState(() {
                        //keys = keyList;
                      });
                    }),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      if(index == 0) {
                        return Column(
                          children: [
                            _buildHeader(titleList),
                            _buildKeyRow(users[index], context)
                          ],
                        );
                      } else {
                        return _buildKeyRow(users[index], context);
                      }
                    }
                ),
              ),
              Center(
                child: CustomButton(
                  onPressed: () {
                    print('Insert Button Pressed');
                    _keyController.clear();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Insert'),
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
                                    //insert(key);
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

  Widget _buildKeyRow(UserList user, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "${user.id}",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              user.user,
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
                  _keyController.clear();
                  _keyController.text = user.password;
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
                              //delete(key.id);
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
                              //update(key.id, _key);
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

void insert(String name, String user, String password) async {
  DBHelper dbHelper = DBHelper();
  await dbHelper.initdb();
  await dbHelper.insertUser(name, user, password);
  print("Insert data: $name, $user, $password");
}

Future<List<UserList>> getKey(String search) async {
  DBHelper dbHelper = DBHelper();
  await dbHelper.initdb();
  List<UserList> users = await dbHelper.getUser(search);
  print("get user data:");
  for(var user in users) {
    print("ID: ${user.id}, Name: ${user.name}, User: ${user.user}, Password: ${user.password}");
  }
  return users;
}

void geAll() async {
  DBHelper dbHelper = DBHelper();
  await dbHelper.initdb();
  List<UserList> users = await dbHelper.getAllUser();
  print("get user data:");
  for(var user in users) {
    print("ID: ${user.id}, Name: ${user.name}, User: ${user.user}, Password: ${user.password}");
  }
}

void update(int id, String name, String user, String password) async {
  DBHelper dbHelper = DBHelper();
  await dbHelper.initdb();
  UserList users = UserList(id, name, user, password);
  await dbHelper.updateUser(users);
}

void delete(int id) async {
  DBHelper dbHelper = DBHelper();
  await dbHelper.initdb();
  await dbHelper.delete(id);
  print('delete $id');
}