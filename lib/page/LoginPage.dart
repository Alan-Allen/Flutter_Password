import 'package:flutter/material.dart';
import 'package:password/DB/DBHelper.dart';
import 'package:password/component/Button.dart';

import '../DB/UserList.dart';
import '../routes/router.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
        title: const Text('Login Page'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: 500,
                    child: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          hintText: 'Enter your username',
                          labelText: 'Username',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 3, color: Colors.greenAccent),
                            borderRadius: BorderRadius.circular(50.0),
                        )
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 500,
                    child: PasswordField(
                      controller: _passwordController,
                      labelText: "Password *",
                      hintText: 'Enter your password',
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: CustomButton(
                    onPressed: () async {
                      print('Login Button Pressed');
                      String userName = _usernameController.text;
                      String password = _passwordController.text;
                      _usernameController.clear();
                      _passwordController.clear();
                      bool login = await Login(userName, password);
                      print('user: $userName, password: $password, Login?: $login');
                    },
                    text: 'Login',
                    color: Colors.blue,
                    textColor: Colors.white,
                    width: 50, height: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;

  const PasswordField({
    required this.controller,
    required this.labelText,
    required this.hintText,
  });

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: _obscureText ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        labelText: widget.labelText,
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: Colors.greenAccent),
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}

Future<bool> Login(String user, String password) async {
  try {
    DBHelper dbHelper = DBHelper();
    await dbHelper.initdb();
    List<UserList> users = await dbHelper.getUser(user);
    print('User data: ');
    for(var user in users) {
      print('ID: ${user.id}, Name: ${user.name}, User: ${user.user}, Password: ${user.password}');
    }
    return users.isNotEmpty && users.first.password == password;
  } catch (e) {
    print("Error Login user: $e");
    return false;
  }
}