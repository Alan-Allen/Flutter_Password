import 'package:flutter/material.dart';
import 'package:password/component/Button.dart';

import '../routes/router.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            print('Back to home');
            router.go('/');
          },
          icon: const Icon(Icons.home),
        ),
        title: const Text('Sign Up'),
        actions: [
          CustomButton(
              onPressed: () {
                print('Login');
                router.go('/login');
              },
              text: 'Login',
              color: Colors.blue,
              textColor: Colors.white,
              width: 10, height: 10
          ),
          const SizedBox(width: 20),
        ],
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
                      controller: _nameController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person_outline),
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
                const SizedBox(height: 30),
                Center(
                  child: SizedBox(
                    width: 500,
                    child: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_open_outlined),
                          hintText: 'Enter your password',
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 3, color: Colors.greenAccent),
                            borderRadius: BorderRadius.circular(50.0),
                          )
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Center(
                  child: CustomButton(
                    onPressed: () async {
                      print('Sign Up Button Pressed');
                      String name = _nameController.text;
                      String userName = _usernameController.text;
                      String password = _passwordController.text;
                      _usernameController.clear();
                      _passwordController.clear();
                      _nameController.clear();
                    },
                    text: 'Sign Up',
                    color: Colors.orange,
                    textColor: Colors.white,
                    width: 50, height: 15,
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