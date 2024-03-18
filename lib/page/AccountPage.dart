import 'package:flutter/material.dart';
import '../DB/DBHelper.dart';
import '../DB/UserList.dart';
import '../component/Button.dart';
import '../routes/router.dart';

class AccountPage extends StatefulWidget {
  final String id;

  AccountPage({Key? key, required this.id}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _usercontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  late List<UserList> users = [];
  late int ID = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ID = int.tryParse(widget.id) ?? -1;
    if (ID != null) {
      getKeysFromDB();
    }
  }

  void getKeysFromDB() async {
    print('ID: $ID');
    List<UserList> userList = await getUser(ID);
    setState(() {
      users = userList;
      _namecontroller.text = users.first.name;
      _usercontroller.text = users.first.user;
      _passwordcontroller.text = users.first.password;
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
        title: const Text('Account Management'),
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
            const SizedBox(height: 50),
            const Center(
              child: Text(
                  '編輯帳號',
                  style: TextStyle(
                    fontSize: 20,
                  ),
              ),
            ),
            const SizedBox(height: 100),
            SizedBox(
              width: 500,
              child: TextField(
                controller: _namecontroller,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.drive_file_rename_outline),
                  hintText: 'Your Name',
                  label: const Text('Name'),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 3),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 500,
              child: TextField(
                controller: _usercontroller,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person_outline),
                  hintText: 'Your UserName',
                  label: const Text('User'),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 3),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 500,
              child: TextField(
                controller: _passwordcontroller,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outlined),
                  hintText: 'Your Password',
                  label: const Text('Password'),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 3),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100),
            Center(
              child: CustomButton(
                onPressed: () {
                  print('Update Button Pressed');
                },
                text: 'Update',
                color: Colors.blue,
                textColor: Colors.white,
                width: 30, height: 15,
              ),
            ),
          ],
        ),
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
}

void insert(String name, String user, String password) async {
  DBHelper dbHelper = DBHelper();
  await dbHelper.initdb();
  await dbHelper.insertUser(name, user, password);
  print("Insert data: $name, $user, $password");
}

Future<List<UserList>> getUser(int id) async {
  DBHelper dbHelper = DBHelper();
  await dbHelper.initdb();
  List<UserList> users = await dbHelper.getUserID(id);
  print("get user data:");
  for (var user in users) {
    print("ID: ${user.id}, Name: ${user.name}, User: ${user.user}, Password: ${user.password}");
  }
  return users;
}

void getAll() async {
  DBHelper dbHelper = DBHelper();
  await dbHelper.initdb();
  List<UserList> users = await dbHelper.getAllUser();
  print("get user data:");
  for (var user in users) {
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
