import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:password/component/Button.dart';

import '../routes/router.dart';

class RandomPage extends StatefulWidget {
  const RandomPage({super.key});

  @override
  _RandomPageState createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {

  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _characterController = TextEditingController();
  final TextEditingController _generatedPasswordController = TextEditingController();
  String _generatedPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            print('Back to Home');
            router.go('/');
          },
          icon: const Icon(Icons.home),
        ),
        title: const Text('Random Password'),
      ),
      body:Stack(
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
                      controller: _lengthController,
                      decoration: InputDecoration(
                        hintText: 'Enter length',
                        labelText: 'length',
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(width: 3, color: Colors.greenAccent),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: SizedBox(
                    width: 500,
                    child: TextField(
                      controller: _characterController,
                      decoration: InputDecoration(
                        hintText: 'Enter character',
                        labelText: 'character',
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(width: 3, color: Colors.greenAccent),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                CustomButton(
                    onPressed: () {
                      print('Create Button Pressed');
                      String length = _lengthController.text;
                      String character = _characterController.text;
                      if (character.isEmpty) {
                        character = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()-_=+';
                      }
                      int passwordLength = int.tryParse(length) ?? 8;
                      setState(() {
                        _generatedPassword = generatePassword(passwordLength, allowedCharacters: character);
                        _generatedPasswordController.text = _generatedPassword;
                        print('Length: $length, Character: $character, Password: $_generatedPassword');
                      });
                    },
                    text: 'Random',
                    color: Colors.blue,
                    textColor: Colors.white,
                    width: 150, height: 15
                ),
                const SizedBox(height: 10),
                Center(
                  child: SizedBox(
                    width: 500,
                    child: TextField(
                      controller: _generatedPasswordController,
                      decoration: InputDecoration(
                        hintText: 'Random Password',
                        labelText: 'Random Password',
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(width: 3, color: Colors.greenAccent),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
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

String generatePassword(int length, {String? allowedCharacters}) {
  allowedCharacters ??= '';
  Random random = Random();
  String password = '';
  for(int i = 0; i < length; i++) {
    int index = random.nextInt(allowedCharacters.length);
    password += allowedCharacters[index];
  }
  return password;
}